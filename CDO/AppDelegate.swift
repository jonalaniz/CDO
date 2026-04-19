//
//  AppDelegate.swift
//  CDO
//
//  Created by Jon Alaniz on 10/13/25.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    let coordinator = CDOCoordinator.shared
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        coordinator.start()
        setupWindow()
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    private func setupWindow() {
        window = NSWindow(
            contentRect: .init(x: 0, y: 0, width: 800, height: 480),
            styleMask: [.titled, .closable, .resizable, .miniaturizable, .unifiedTitleAndToolbar],
            backing: .buffered,
            defer: false
        )

        window.title = "CDO"
        window.center()
        window.makeKeyAndOrderFront(nil)
    }
}
