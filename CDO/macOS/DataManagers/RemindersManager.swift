//
//  RemindersManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import AppKit

final class RemindersManager: NSObject {
    static let shared = RemindersManager()
    private let service = CDOService.shared
    var reminders = [Reminder]()
    weak var delegate: DataManagerDelegate?
    private var sortedByColumn: Column?

    private override init() {}

    func fetchReminders() {
        Task {
            do {
                reminders = try await service.fetchCalendars(withClients: true)
                    .sorted {
                    $0.id < $1.id
                }
                updateDelegate()
            } catch {
                print(error)
            }
        }
    }

    @MainActor
    private func updateDelegate() {
        delegate?.didUpdateClients()
    }
}

extension RemindersManager: NSTableViewDelegate, NSTableViewDataSource {
    private enum Column: String, CaseIterable {
        case clentName = "ClientNameID"
        case actionDate = "ActionDateID"
        case description = "DescriptionID"
        case completed = "CompletedID"

        var identifier: NSUserInterfaceItemIdentifier {
            .init(rawValue)
        }
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return reminders.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard
            let tableColumn = tableColumn,
            let column = Column(rawValue: tableColumn.identifier.rawValue)
        else { return nil }

        let reminder = reminders[row]

        guard let view = tableView.makeView(
            withIdentifier: column.identifier, owner: self
        ) as? NSTableCellView else {
            print("Cannot cast CellView")
            return nil
        }

        switch column {
        case .clentName: 
            view.textField?.stringValue = reminder.clientName ?? ""
        case .actionDate: 
            view.textField?.stringValue = reminder.actionDate?.formatted() ?? ""
        case .description: 
            view.textField?.stringValue = reminder.description ?? ""
        case .completed:
            view.textField?.stringValue = completedStatusString(reminder.complete)
        }

        return view
    }

    private func completedStatusString(_ status: Bool?) -> String {
        guard
            let status = status,
            status != false
        else { return "❌" }

        return "✅"
    }
}
