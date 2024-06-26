// The Swift Programming Language
// https://docs.swift.org/swift-book

import Adwaita

@main
struct Reversi: App {

    let id = "nz.school.OnslowCollege.Reversi"
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "main") { window in

                .padding()
                .topToolbar {
                    ToolbarView(app: app, window: window)
                }
        }
        .defaultSize(width: 450, height: 300)
    }

}
