//
//  TodoListMigration.swift
//  App
//
//  Created by Volodymyr Hryhoriev on 02.05.2020.
//

import Fluent

struct TodoListMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(TodoList.schema)
            .id()
            .field("list", .array(of: .data))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(TodoList.schema).delete()
    }
}
