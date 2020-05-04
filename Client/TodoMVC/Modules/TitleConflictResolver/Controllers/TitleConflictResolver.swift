//
//  TitleConflictResolverViewController.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 04.05.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

final class TitleConflictResolverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var didTitleSelected: ((String) -> Void)?
    var titles: [String] = []

    @IBOutlet var titlesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        isModalInPresentation = true

        titlesTableView.delegate = self
        titlesTableView.dataSource = self
        titlesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "title-cell")
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "title-cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTitleSelected?(titles[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
