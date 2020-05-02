//
//  TodoListMapper.swift
//  App
//
//  Created by Volodymyr Hryhoriev on 02.05.2020.
//

import TodoModel
import Foundation

extension TodoList {
    convenience init(list: [TodoItemDTO]) {
        self.init(list: list.compactMap { $0.data })
    }

    var dtoList: [TodoItemDTO] {
        return list.compactMap(TodoItemDTO.create(from:))
    }
}

extension TodoItemDTO {
    static func create(from data: Data) -> TodoItemDTO? {
        return try? JSONDecoder().decode(TodoItemDTO.self, from: data)
    }

    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
}
