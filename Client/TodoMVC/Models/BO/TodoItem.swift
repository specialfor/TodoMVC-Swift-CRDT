//
//  TodoItem.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 28.04.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

import Foundation
import UIKit

struct TodoItem: Hashable {
    private static var _id = UserDefaults.standard.integer(forKey: "id")

    let id: String
    var title: String
    var tags: [String]
    var isDone: Bool

    init(title: String, tags: Set<String>, isDone: Bool) {
        self.id = "\(UIDevice.current.identifierForVendor!)_\(TodoItem._id)"

        TodoItem._id += 1
        UserDefaults.standard.set(TodoItem._id, forKey: "id")

        self.title = title
        self.tags = Array(tags)
        self.isDone = isDone
    }
}
