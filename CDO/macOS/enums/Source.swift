//
//  Source.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import AppKit

enum Source: String, CaseIterable {
    case main = "Main"
    case administrative = "Administrative"

    var identifier: NSUserInterfaceItemIdentifier {
        return NSUserInterfaceItemIdentifier("HeaderCell")
    }

    var children: [Any] {
        switch self {
        case .main: MainSource.allCases
        case .administrative: AdministrativeSource.allCases
        }
    }

    private var symbolName: String {
        switch self {
        case .main: "figure.open.water.swim.circle"
        case .administrative: "figure.open.water.swim.circle"
        }
    }

    var image: NSImage? {
        .init(systemSymbolName: symbolName, accessibilityDescription: "")
    }
}

enum MainSource: String, CaseIterable {
    case remindersList = "Reminders"
    case clientList = "Clients"
    case employerList = "Employers"

    var identifier: NSUserInterfaceItemIdentifier {
        return NSUserInterfaceItemIdentifier("DataCell")
    }

    private var symbolName: String {
        switch self {
        case .remindersList: "\(calendarDate())calendar"
        case .clientList: "person"
        case .employerList: "list.bullet.clipboard"
        }
    }

    var image: NSImage? {
        .init(systemSymbolName: symbolName, accessibilityDescription: "")
    }

    func calendarDate() -> String {
        let date = Calendar.current
        let components = date.dateComponents([.day], from: .now)
        guard let day = components.day else { return "" }
        return String(day) + "."

    }
}

enum AdministrativeSource: String, CaseIterable {
    case clientDatabase = "Client Database"

    var identifier: NSUserInterfaceItemIdentifier {
        return NSUserInterfaceItemIdentifier("DataCell")
    }

    private var symbolName: String {
        switch self {
        case .clientDatabase: "info.circle.text.page"
        }
    }

    var image: NSImage? {
        .init(systemSymbolName: symbolName, accessibilityDescription: "")
    }
}
