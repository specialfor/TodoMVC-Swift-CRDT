//
//  TodoItemCell.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 27.04.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

final class TodoItemCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tagsLabel: UILabel!
    @IBOutlet var doneButton: UIButton!

    // MARK: - Configure

    private var viewModel: ViewModel?

    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        configureTagsView(using: viewModel.tags)
        doneButton.isSelected = viewModel.isDone
    }

    private func configureTagsView(using tags: [String]) {
        let tagsText = "Tags: " + tags.joined(separator: ", ")
        let attributedString = NSMutableAttributedString(string: tagsText)
        attributedString.addAttributes([.font: UIFont.boldSystemFont(ofSize: 15)], range: .init(location: 0, length: 5))
        tagsLabel.attributedText = attributedString
    }

    // MARK: - Actions
    
    @IBAction func toggleDone(_ sender: Any) {
        viewModel?.toggleDone()
    }
}

extension TodoItemCell {
    struct ViewModel {
        let title: String
        let tags: [String]
        let isDone: Bool
        let toggleDone: () -> Void
    }
}
