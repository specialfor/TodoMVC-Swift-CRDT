//
//  TodoItemMapper.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 01.05.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

import TodoModel
import CRDT

extension TodoItem {
    init(dto: TodoItemDTO) {
        self.id = dto.id
        self.title = dto.title.value.first?.value ?? ""
        self.tags = Array(dto.tags.value).sorted()
        self.isDone = dto.isDone.value
    }
}

extension TodoItemDTO {
    init(bo: TodoItem) {
        self.init(id: bo.id,
                  title: MVRegister(value: bo.title),
                  tags: AWSet(bo.tags),
                  isDone: EWFlag(bo.isDone))
    }
}
