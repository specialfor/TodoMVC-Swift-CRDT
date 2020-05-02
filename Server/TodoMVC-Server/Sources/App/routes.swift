import Fluent
import Vapor

func routes(_ app: Application) throws {
    let todoController = TodoController()
    app.get("todos", use: todoController.index(request:))
    app.post("todos", use: todoController.create(request:))
//    app.delete("todos", ":todoID", use: todoController.delete)
}
