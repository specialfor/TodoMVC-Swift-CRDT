//
//  TodoListViewController.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 27.04.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit
import KeyboardLayoutGuide

final class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    // MARK: - Outlets

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var bottomActionsView: UIStackView!
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var createButton: UIButton!

    // MARK: - Properties

    private var items: [TodoItem] {
        return Store.shared.todoList
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.bottomAnchor.constraint(
            equalTo: view.keyboardLayoutGuide.topAnchor,
            constant: -16).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Actions

    @IBAction private func create(_ sender: Any) {
        Store.shared.add(
            item: .init(
                title: titleTextField.text ?? "",
                tags: [],
                isDone: false))

        titleTextField.text = nil
        createButton.isEnabled = false
        tableView.reloadData()
    }

    @IBAction private func typeTitle(_ sender: Any) {
        createButton.isEnabled = !(titleTextField.text ?? "").isEmpty
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo-item", for: indexPath) as! TodoItemCell
        let item = items[indexPath.row]
        cell.configure(
            with: .init(
                title: item.title,
                tags: item.tags,
                isDone: item.isDone,
                toggleDone: {
                    var item = item
                    item.isDone.toggle()
                    Store.shared.update(item: item)
                    tableView.reloadRows(at: [indexPath], with: .none)
            }))
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        performSegue(
            withIdentifier: "show-details",
            sender: item)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "show-details",
            let destinationVC = segue.destination as? TodoDetailsViewController,
            let item = sender as? TodoItem else {
                return
        }

        destinationVC.viewModel = item
    }
}
