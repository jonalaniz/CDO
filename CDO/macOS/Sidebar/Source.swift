//
//  Source.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import AppKit

enum SourceItem: String, CaseIterable {
    // Headers
    case main = "Personnel"
    case administrative = "Administrative"

    // Main Sources
    case reminders = "Reminders"
    case clients = "Clients"
    case counselors = "Counselors"
    case employers = "Employers"

    // Administrative Sources
    case sas = "Service Authorizations"
    case placements = "Placements"

    static var rootItems: [SourceItem] = [.main, .administrative]

    var parent: SourceItem? {
        switch self {
        case .reminders, .clients, .counselors, .employers:
            return .main
        case .sas, .placements:
            return .administrative
        default: return nil
        }
    }

    var children: [SourceItem] {
        switch self {
        case .main, .administrative: return SourceItem.allCases.filter { $0.parent == self }
        default: return []
        }
    }

    var isHeader: Bool {
        return !children.isEmpty
    }

    var identifier: NSUserInterfaceItemIdentifier {
        return .init(isHeader ? "HeaderCell" : "DataCell")
    }

    var inspectorIdentifier: String {
        return self.rawValue + ".Inspector"
    }

    var image: NSImage? {
        guard let symbolName = symbolName else { return nil }
        return .init(systemSymbolName: symbolName, accessibilityDescription: "")
    }

    private var symbolName: String? {
        switch self {
        case .reminders: "\(currentDate())calendar"
        case .clients: "person"
        case .employers: "building.2"
        case .counselors: "list.bullet.clipboard"
        case .placements: "briefcase"
        case .sas: "scroll"
        default: nil
        }
    }

    private func currentDate() -> String {
        let components = Calendar.current.dateComponents([.day], from: .now)
        guard let day = components.day else { return "" }
        return String(day) + "."
    }
}
