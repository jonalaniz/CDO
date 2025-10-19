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
    }
}
