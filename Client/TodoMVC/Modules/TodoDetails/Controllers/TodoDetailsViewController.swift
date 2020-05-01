//
//  TodoDetailsViewController.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 28.04.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

final class TodoDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var viewModel: ViewModel!
    var tags: [String] = []

    // MARK: - Outlets

    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var tagsTableView: UITableView!
    @IBOutlet var addButton: UIButton!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true

        tags = viewModel.tags
        render(viewModel)
    }

    private func render(_ viewModel: ViewModel) {
        renderDoneButton(viewModel.isDone)
        titleTextField.text = viewModel.title
        tagsTableView.reloadData()
    }

    private func renderDoneButton(_ isDone: Bool) {
        doneButton.image = isDone
            ? UIImage(named: "baseline_check_circle_outline_black_24pt")
            : UIImage(named: "baseline_radio_button_unchecked_black_24pt")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.tags = tags.filter { !$0.isEmpty }
        Store.shared.update(item: viewModel)
    }

    // MARK: - Actions

    @IBAction func toggleDone(_ sender: Any) {
        viewModel.isDone.toggle()
        Store.shared.update(item: viewModel)
        renderDoneButton(viewModel.isDone)
    }

    @IBAction func titleChanged(_ sender: Any) {
        viewModel.title = titleTextField.text ?? ""
        Store.shared.update(item: viewModel)
    }

    private var addAction: UIAlertAction?

    @IBAction func addTag(_ sender: Any) {
        let alert = UIAlertController(title: "Add tag", message: nil, preferredStyle: .alert)

        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            let text = alert.textFields![0].text ?? ""
            self.tags.append(text)
            self.tagsTableView.reloadData()
        }
        addAction.isEnabled = false
        self.addAction = addAction

        alert.addAction(addAction)

        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))

        alert.addTextField { textField in
            textField.placeholder = "E.g. Work..."
            textField.addTarget(self, action: #selector(self.tagTextFieldChanged(_:)), for: .editingChanged)
        }

        present(alert, animated: true, completion: nil)
    }

    @objc private func tagTextFieldChanged(_ textField: UITextField) {
        addAction?.isEnabled = !(textField.text ?? "").isEmpty
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tag-item", for: indexPath) as! TagCell
        cell.configure(
            with: .init(
                tag: tags[indexPath.row],
                editingChanged: { tag in
                    self.tags[indexPath.row] = tag
            }))
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            .init(style: .destructive, title: "Delete", handler: { action, view, completion in
                self.tags.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                completion(true)
            })
        ])
    }
}

extension TodoDetailsViewController {
    typealias ViewModel = TodoItem
}
