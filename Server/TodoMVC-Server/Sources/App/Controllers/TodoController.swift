import Fluent
import Vapor
import TodoModel
import CRDT

struct TodoController {
    func index(request: Request) throws -> EventLoopFuture<AWSet<TodoItemDTO>> {
        return fetchTodoSet(from: request)
            .map { $0?.awSet ?? [] }
    }

    func create(request: Request) throws -> EventLoopFuture<String> {
        let set = try request.content.decode(AWSet<TodoItemDTO>.self)

        return fetchTodoSet(from: request).map { (oldList: TodoList?) -> (TodoList, Bool) in
            guard let oldList = oldList else {
                return (TodoList(data: set.data), false)
            }

            let mergedSet = oldList.awSet.merging(set)
            oldList.data = mergedSet.data

            return (oldList, true)
        }
        .flatMap { (pair: (TodoList, Bool)) -> EventLoopFuture<String> in
            if pair.1 {
                return pair.0.update(on: request.db).map { "Todo List is updated." }
            } else {
                return pair.0.create(on: request.db).map { "Todo List is saved." }
            }
        }
    }

    func clear(request: Request) throws -> EventLoopFuture<String> {
        return TodoList.query(on: request.db).all()
            .map { list in
                list.forEach { $0.delete(on: request.db) }
                return "Cleared"
            }
    }

    private func fetchTodoSet(from request: Request) -> EventLoopFuture<TodoList?> {
        return TodoList.query(on: request.db)
            .all()
            .map { $0.first }
    }
}

extension TodoItemDTO: Content {}

extension AWSet: ResponseEncodable where T: Content {}
extension AWSet: RequestDecodable where T: Content {}
extension AWSet: Content where T: Content {}
