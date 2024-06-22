import Adwaita

struct ToolbarView: View {

    var app: GTUIApp
    var window: GTUIApplicationWindow

    var view: Body {
        HeaderBar.end {
            Menu(icon: .default(icon: .openMenu), app: app, window: window) {
                MenuButton("New window", window: false) {
                    app.addWindow("main")
                }
                .keyboardShortcut("n".ctrl())
                MenuButton("Close") {
                    window.close()
                }
                .keyboardShortcut("w".ctrl())
                MenuSection {
                    MenuButton("Quit", window: false) {
                        app.quit()
                    }
                    .keyboardShortcut("q".ctrl())
                }
            }
            .primary()
            .tooltip("Main menu")
        }
    }

}
