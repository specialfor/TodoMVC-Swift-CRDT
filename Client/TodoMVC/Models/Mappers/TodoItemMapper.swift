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
        self.titles = dto.title.value.map { $0.value }
        self.tags = Array(dto.tags.value).sorted()
        self.isDone = dto.isDone.value
    }
}

extension TodoItemDTO {
    init(bo: TodoItem) {
        var register = MVRegister<String>()
        register.assign(Set(bo.titles))
        
        self.init(id: bo.id,
                  title: register,
                  tags: AWSet(bo.tags),
                  isDone: EWFlag(bo.isDone))
    }
}
