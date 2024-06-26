//
// Subtasks.swift
// Subtasks
//

import Adwaita

struct Subtasks: App {


    @State private var tasks: [Task] = [
        .init(label: "Hello"),
        .init(label: "World"),
        .init(label: "Complete", done: true)
    ]
    let id = "io.github.david_swift.Subtasks"
    var app: GTUIApp!
}