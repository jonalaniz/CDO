//
//  Source.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import AppKit
import Foundation

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
        case .remindersList: "figure.open.water.swim.circle"
        case .clientList: "figure.open.water.swim.circle"
        case .employerList: "figure.open.water.swim.circle"
        }
    }

    var image: NSImage? {
        .init(systemSymbolName: symbolName, accessibilityDescription: "")
    }
}

enum AdministrativeSource: String, CaseIterable {
    case clientDatabase = "Client Database"

    var identifier: NSUserInterfaceItemIdentifier {
        return NSUserInterfaceItemIdentifier("DataCell")
    }

    private var symbolName: String {
        switch self {
        case .clientDatabase: "figure.open.water.swim.circle"
        }
    }

    var image: NSImage? {
        .init(systemSymbolName: symbolName, accessibilityDescription: "")
    }
}
