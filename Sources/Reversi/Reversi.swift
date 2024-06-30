// // The Swift Programming Language
// // https://docs.swift.org/swift-book

// import Adwaita

// @main
// struct Reversi: App {

//     let id = "nz.school.OnslowCollege.Reversi"
//     var app: GTUIApp!

//     var scene: Scene {
//         Window(id: "main") { window in
//             Text("NotReversi")
//                 .padding()
//                 .topToolbar {
//                     ToolbarView(app: app, window: window)
//                 }
//         }
//         .defaultSize(width: 450, height: 300)
//     }

// }
//
//  DiceDemo.swift
//  Adwaita
//
//  Created by david-swift on 12.10.23.
//

// swiftlint:disable missing_docs no_magic_numbers

import Adwaita

@main

struct DiceDemo: View {


    @State private var number: Int?

    private var label: String {
        if let number {
            return "\(number)"
        } else {
            return "Roll the Dice!"
        }
    }

    var view: Body {
        VStack {
            Button(label) {
                number = .random(in: 1...6)
            }
            .pill()
            .suggested()
            .style("dice-button")
            .css {
                """
                .dice-button {
                    background-color: @green_5;
                }
                """
            }
            .frame(maxWidth: 100)
        }
        .valign(.center)
        .padding()
    }

}

// swiftlint:enable missing_docs no_magic_numbers