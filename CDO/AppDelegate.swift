//
//  AppDelegate.swift
//  CDO
//
//  Created by Jon Alaniz on 10/13/25.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    let coordinator = CDOCoordinator.shared

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        coordinator.start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

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
        return NSWindow(
            contentRect: .init(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .resizable, .miniaturizable, .unifiedTitleAndToolbar],
            backing: .buffered,
            defer: false
        )
    }
}
