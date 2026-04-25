//
//  WindowFactory.swift
//  CDO
//
//  Created by Jon Alaniz on 4/20/26.
//

import Cocoa

struct WindowFactory {
    static func makeMainWindow() -> NSWindow {
        let window = makeBaseWindow()
        window.title = "CDO"
        return window
    }

    static func makeCalendarWindow() -> NSWindow {
        let window = makeBaseWindow()
        window.title = "Calendar"
        return window
    }

    static private func makeBaseWindow() -> NSWindow {
        let window = NSWindow(
            contentRect: .init(x: 0, y: 0, width: 480, height: 270),
            styleMask: [.titled, .closable, .resizable, .miniaturizable, .unifiedTitleAndToolbar, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )

        window.toolbarStyle = .unified
        window.titlebarSeparatorStyle = .automatic
        window.minSize = .init(width: 800, height: 480)

        return window
    }
}
