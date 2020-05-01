//
//  TagCell.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 28.04.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

final class TagCell: UITableViewCell {
    @IBOutlet private var textField: UITextField!

    private var viewModel: ViewModel?

    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        textField.text = viewModel.tag
    }

    @IBAction func editingChanged(_ sender: Any) {
        viewModel?.editingChanged(textField.text ?? "")
    }
}

extension TagCell {
    struct ViewModel {
        let tag: String
        let editingChanged: (String) -> Void
    }
}
