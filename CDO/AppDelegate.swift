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
