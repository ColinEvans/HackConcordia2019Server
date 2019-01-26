import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("plays", use: todoController.index)
    router.post("plays", use: todoController.create)
    router.delete("plays", plays.parameter, use: todoController.delete)
}
