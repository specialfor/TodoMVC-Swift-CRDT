//
//  TodoList.swift
//  App
//
//  Created by Volodymyr Hryhoriev on 02.05.2020.
//

import Foundation
import Fluent
import TodoModel

final class TodoList: Model {
    static var schema: String = "todo-list"
    static var id = 0

    @ID(custom: .id)
    var id: Int?

    @Field(key: "list")
    var list: [Data]

    init() {}

    init(list: [Data] = []) {
        self.id = TodoList.id
        self.list = list
    }
}
