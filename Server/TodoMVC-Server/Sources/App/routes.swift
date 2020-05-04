import Fluent
import Vapor

func routes(_ app: Application) throws {
    let todoController = TodoController()
    app.get("todos", use: todoController.index(request:))
    app.on(.POST, "todos", body: .collect(maxSize: 1 << 62), use: todoController.create(request:))
    app.delete("todos", use: todoController.clear(request:))
}
