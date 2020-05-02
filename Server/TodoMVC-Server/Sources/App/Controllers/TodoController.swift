import Fluent
import Vapor
import TodoModel

struct TodoController {
    func index(request: Request) throws -> EventLoopFuture<[TodoItemDTO]> {
        return TodoList.query(on: request.db)
            .all()
            .map { $0.first?.dtoList ?? [] }
    }

    func create(request: Request) throws -> EventLoopFuture<String> {
        let list = try request.content.decode([TodoItemDTO].self)
        let todoList = TodoList(list: list)
        return todoList.create(on: request.db).map { "Todo List is saved." }
    }
}


extension TodoItemDTO: Content {
    
}
