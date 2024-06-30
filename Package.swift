// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Reversi",
    platforms: [.macOS("10.15")],
    dependencies: [
        .package(url: "https://github.com/AparokshaUI/Adwaita", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            name: "Reversi",
            dependencies: [.product(name: "Adwaita", package: "Adwaita"), .product(name: "OCGUI", package: "OCGUI")],
            swiftSettings: [
                .unsafeFlags(["-I", "C:\\gtk4\\include\\cairo", "-I", "C:\\gtk4\\include\\epoxy", "-I", "C:\\gtk4\\include\\freetype2", "-I", "C:\\gtk4\\include\\fribidi", "-I", "C:\\gtk4\\include\\gdk-pixbuf-2.0", "-I", "C:\\gtk4\\include\\gio-win32-2.0", "-I", "C:\\gtk4\\include\\glib-2.0", "-I", "C:\\gtk4\\include\\graphene-1.0", "-I", "C:\\gtk4\\include\\gtk-4.0", "-I", "C:\\gtk4\\include\\harfbuzz", "-I", "C:\\gtk4\\include\\libadwaita-1", "-I", "C:\\gtk4\\include\\libpng16", "-I", "C:\\gtk4\\include\\librsvg-2.0", "-I", "C:\\gtk4\\include\\libxml2", "-I", "C:\\gtk4\\include\\pango-1.0", "-I", "C:\\gtk4\\include\\pixman-1", "-I", "C:\\gtk4\\lib\\glib-2.0\\include", "-I", "C:\\gtk4\\lib\\graphene-1.0\\include"], .when(platforms: [.windows]))
            ],
            linkerSettings: [
                .unsafeFlags(["C:\\gtk4\\lib\\adwaita-1.lib", "C:\\gtk4\\lib\\asprintf.lib", "C:\\gtk4\\lib\\cairo-gobject.lib", "C:\\gtk4\\lib\\cairo-script-interpreter.lib", "C:\\gtk4\\lib\\cairo.lib", "C:\\gtk4\\lib\\epoxy.lib", "C:\\gtk4\\lib\\ffi.lib", "C:\\gtk4\\lib\\freetype.lib", "C:\\gtk4\\lib\\fribidi.lib", "C:\\gtk4\\lib\\gdk_pixbuf-2.0.lib", "C:\\gtk4\\lib\\gettextpo.lib", "C:\\gtk4\\lib\\gio-2.0.lib", "C:\\gtk4\\lib\\girepository-1.0.lib", "C:\\gtk4\\lib\\girepository-2.0.lib", "C:\\gtk4\\lib\\glib-2.0.lib", "C:\\gtk4\\lib\\gmodule-2.0.lib", "C:\\gtk4\\lib\\gobject-2.0.lib", "C:\\gtk4\\lib\\graphene-1.0.lib", "C:\\gtk4\\lib\\gthread-2.0.lib", "C:\\gtk4\\lib\\gtk-4.lib", "C:\\gtk4\\lib\\gtksourceview-5.lib", "C:\\gtk4\\lib\\harfbuzz-cairo.lib", "C:\\gtk4\\lib\\harfbuzz-gobject.lib", "C:\\gtk4\\lib\\harfbuzz-subset.lib", "C:\\gtk4\\lib\\harfbuzz.lib", "C:\\gtk4\\lib\\iconv.lib", "C:\\gtk4\\lib\\intl.lib", "C:\\gtk4\\lib\\jpeg-static.lib", "C:\\gtk4\\lib\\jpeg.lib", "C:\\gtk4\\lib\\libpng16.lib", "C:\\gtk4\\lib\\libpng16_static.lib", "C:\\gtk4\\lib\\libxml2.lib", "C:\\gtk4\\lib\\pango-1.0.lib", "C:\\gtk4\\lib\\pangocairo-1.0.lib", "C:\\gtk4\\lib\\pangowin32-1.0.lib", "C:\\gtk4\\lib\\pcre2-16.lib", "C:\\gtk4\\lib\\pcre2-32.lib", "C:\\gtk4\\lib\\pcre2-8.lib", "C:\\gtk4\\lib\\pcre2-posix.lib", "C:\\gtk4\\lib\\pixman-1.lib", "C:\\gtk4\\lib\\pkgconf.lib", "C:\\gtk4\\lib\\rsvg-2.0.lib", "C:\\gtk4\\lib\\tiff.lib", "C:\\gtk4\\lib\\tiffxx.lib", "C:\\gtk4\\lib\\turbojpeg-static.lib", "C:\\gtk4\\lib\\turbojpeg.lib", "C:\\gtk4\\lib\\zlib1.lib"], .when(platforms: [.windows]))
            ]
        )
    ]
)
