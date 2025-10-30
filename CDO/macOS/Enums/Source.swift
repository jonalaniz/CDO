//
//  Source.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import AppKit

enum SourceItem: String, CaseIterable {
    // Headers
    case main = "Main"
    case administrative = "Administrative"

    // Main Sources
    case reminders = "Reminders"
    case clients = "Clients"
    case employers = "Employers"

    // Administrative Sources
    case clientDatabase = "Client Database"
    case counselorDatabase = "Counselor Database"
    case employerDatabase = "Employer Database"
    case referralDatabase = "Referral Database"
    case poDatabase = "PO Database"

    static var rootItems: [SourceItem] = [.main, .administrative]

    var parent: SourceItem? {
        switch self {
        case .reminders, .clients, .employers:
            return .main
        case .clientDatabase, .counselorDatabase, .employerDatabase, .referralDatabase, .poDatabase:
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
        case .employers: "list.bullet.clipboard"
        case .clientDatabase: "info.circle.text.page"
        case .counselorDatabase: "person.line.dotted.person"
        case .employerDatabase: "storefront"
        case .referralDatabase: "briefcase"
        case .poDatabase: "scroll"
        default: nil
        }
    }

    private func currentDate() -> String {
        let components = Calendar.current.dateComponents([.day], from: .now)
        guard let day = components.day else { return "" }
        return String(day) + "."
    }
}
