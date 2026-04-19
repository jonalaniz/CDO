//
//  AppMain.swift
//  CDO
//
//  Created by Jon Alaniz on 4/17/26.
//

import Cocoa

@main
struct AppMain {
    static func main() {
        let delegate = AppDelegate()
        NSApplication.shared.delegate = delegate
        NSApplication.shared.run()
    }
}
