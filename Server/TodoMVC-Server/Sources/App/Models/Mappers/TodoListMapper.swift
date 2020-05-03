//
//  TodoListMapper.swift
//  App
//
//  Created by Volodymyr Hryhoriev on 02.05.2020.
//

import Foundation
import TodoModel
import CRDT

extension TodoList {
    convenience init(set: AWSet<TodoItemDTO>) {
        self.init(data: set.data)
    }

    var awSet: AWSet<TodoItemDTO> {
        return try! JSONDecoder().decode(AWSet<TodoItemDTO>.self, from: data)
    }
}

extension AWSet where T == TodoItemDTO {
    var data: Data {
        return try! JSONEncoder().encode(self)
    }
}
