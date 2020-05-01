//
//  TodoItemMapper.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 01.05.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

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
        self.id = bo.id
        self.title = MVRegister(value: bo.title)
        self.tags = AWSet(bo.tags)
        self.isDone = EWFlag(bo.isDone)
    }
}
