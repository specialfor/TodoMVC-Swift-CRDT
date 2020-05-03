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

    @Field(key: "data")
    var data: Data

    init() {}

    init(data: Data) {
        self.id = TodoList.id
        self.data = data
    }
}
