//
// Task.swift
// Subtasks
//

import Adwaita
import Foundation

struct Task: Codable, Identifiable, CustomStringConvertible {

    var id: UUID = .init()
    var label: String
    var done: Bool = false
    var subtasks: [Self] = []

    var mixed: Bool {
        !done && sybtasks.contains { subtask in
            subtask.mixed || subtask.done
        }
    }

}