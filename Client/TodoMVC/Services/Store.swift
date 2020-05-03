//
//  Store.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 28.04.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

import TodoModel
import CRDT
import Foundation

final class Store {
    static let shared = Store()
    private init() {
        guard let data = UserDefaults.standard.data(forKey: "items") else {
            todoSet = []
            return
        }
        todoSet = try! JSONDecoder().decode(AWSet<TodoItemDTO>.self, from: data)
    }

    var todoList: [TodoItem] {
        return todoSet
            .map(TodoItem.init(dto:))
            .sorted { $0.id > $1.id }
    }
    private var todoSet: AWSet<TodoItemDTO> = []

    func add(item: TodoItem) {
        let dto = TodoItemDTO(bo: item)
        todoSet.insert(dto)
        saveTodoItems()
    }

    private func saveTodoItems() {
        let encoder = JSONEncoder()
        let json = try! encoder.encode(todoSet)
        UserDefaults.standard.set(json, forKey: "items")
    }

    func update(item: TodoItem) {
        guard var dto = todoSet.first(where: { $0.id == item.id }) else {
            return
        }

        dto.title.assign(item.title)
        dto.tags.assign(Set(item.tags))
        dto.isDone.value = item.isDone

        todoSet.update(with: dto)
        saveTodoItems()
    }

    func remove(item: TodoItem) {
        guard let dto = todoSet.first(where: { $0.id == item.id }) else {
            return
        }
        todoSet.remove(dto)
        saveTodoItems()
    }
}
