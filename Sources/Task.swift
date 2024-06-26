//
// Task.swift
// Subtasks
//

import Adwaita

struct Task {

    var label: String
    var done: Bool = false
    var subtasks: [Self] = []

    var mixed: Bool {
        !done && sybtasks.contains { subtask in
            subtask.mixed || subtask.done
        }
    }

}