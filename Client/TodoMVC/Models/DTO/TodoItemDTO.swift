//
//  TodoItemDTO.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 01.05.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

import CRDT

struct TodoItemDTO: Hashable, Codable {
    typealias ID = String
    let id: ID
    var title: MVRegister<String>
    var tags: AWSet<String>
    var isDone: EWFlag

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: TodoItemDTO, rhs: TodoItemDTO) -> Bool {
        return lhs.id == rhs.id
    }
}
