// Important bits
import Fluent
import Vapor


/// the site itself I think
func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("login") { req async -> String in
        "This is where you will log in wooooo!"
    }

    app.get("signup.leaf") { req async -> String in
        "This is where you will log in wooooo!"
    }

    try app.register(collection: TodoController())
}


