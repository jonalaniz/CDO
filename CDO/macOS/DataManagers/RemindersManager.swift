//
//  RemindersManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import AppKit

final class RemindersManager: BaseDataManager {
    // MARK: - Shared Instance
    static let shared = RemindersManager()
    private override init() {}

    var reminders = [Reminder]()
    private var sortedByColumn: Column?

    func fetchReminders() {
        Task {
            do {
                reminders = try await service.fetchReminders(withClients: true)
                    .sorted {
                    $0.id < $1.id
                }
                updateDelegate()
            } catch {
                print(error)
            }
        }
    }

    func fetchReminder(id: Int) {
        Task {
            do {
                let reminder = try await service.fetchReminder(with: id)
                updatedItem(reminder)
            }
        }
    }

    @MainActor
    private func updateDelegate() {
        delegate?.didUpdateItems()
    }

    override func cachedItem(for id: Int) -> Any? {
        return reminders.first(where: { $0.id == id })
    }
}

extension RemindersManager: NSTableViewDelegate, NSTableViewDataSource {
    private enum Column: String, CaseIterable {
        case clentName = "ClientNameID"
        case actionDate = "ActionDateID"
        case description = "DescriptionID"

        var identifier: NSUserInterfaceItemIdentifier {
            .init(rawValue)
        }
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return reminders.count
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        delegate?.didSelect()
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
            view.textField?.stringValue = reminder.actionDate?.formatted(date: .numeric, time: .omitted) ?? ""
        case .description:
            view.textField?.stringValue = reminder.description ?? ""
            view.toolTip = reminder.description ?? ""
        }

        view.layer?.opacity = reminder.complete ? 0.5 : 1.0

        return view
    }
}
