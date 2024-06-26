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
struct Counter: View {

    @State private var count = 0

    var view: Body {
        HStack {
            Button(icon: .default(icon: .goPrevious)) {
                count -= 1
            }
            Text("\(count)")
                .title1()
                .frame(minWidth: 100)
            Button(icon: .default(icon: .goNext)) {
                count += 1
            }
        }
    }

}