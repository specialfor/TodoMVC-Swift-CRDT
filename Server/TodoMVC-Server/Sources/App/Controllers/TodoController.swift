import Fluent
import Vapor
import TodoModel
import CRDT

struct TodoController {
    func index(request: Request) throws -> EventLoopFuture<AWSet<TodoItemDTO>> {
        return TodoList.query(on: request.db)
            .all()
            .map { $0.first?.awSet ?? [] }
    }

    func create(request: Request) throws -> EventLoopFuture<String> {
        let list = try request.content.decode(AWSet<TodoItemDTO>.self)
        let todoList = TodoList(data: list.data)
        return todoList.create(on: request.db).map { "Todo List is saved." }
    }
}

extension TodoItemDTO: Content {}

extension AWSet: ResponseEncodable where T: Content {}
extension AWSet: RequestDecodable where T: Content {}
extension AWSet: Content where T: Content {}
