//
//  Source.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import AppKit
import Foundation

enum Source: CaseIterable {
    case main
    case administrative

    var identifier: NSUserInterfaceItemIdentifier {
        return NSUserInterfaceItemIdentifier("HeaderCell")
    }

    var children: [Any] {
        switch self {
        case .main: MainSource.allCases
        case .administrative: AdministrativeSource.allCases
        }
    }

    var text: String {
        switch self {
        case .main: return "Main"
        case .administrative: return "Administrative"
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

    enum MainSource: CaseIterable {
        case remindersList
        case clientList
        case employerList

        var identifier: NSUserInterfaceItemIdentifier {
            return NSUserInterfaceItemIdentifier("DataCell")
        }

        var text: String {
            switch self {
            case .remindersList: return "Reminders"
            case .clientList: return "Clients"
            case .employerList: return "Employers"
            }
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

    enum AdministrativeSource: CaseIterable {
        case clientDatabase

        var identifier: NSUserInterfaceItemIdentifier {
            return NSUserInterfaceItemIdentifier("DataCell")
        }

        var text: String {
            switch self {
            case .clientDatabase: return "Client Database"
            }
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
}
