//
// Task.swift
// Subtasks
//

import Adwaita

struct Task {

    var label: String
    var done: Bool = false
    var subtasks: [Self] = []

}