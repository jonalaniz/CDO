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

    // MARK: - Properties
    private let service = ReminderService.shared
    private var reminders = [Reminder]()
    private var filteredReminders: [Reminder] {
        reminders.filter { !$0.complete }
    }
    private var sortedByColumn: Column?
    var isFiltered = false

    // MARK: - Public API
    func initialize() async {
        guard let cachedReminders: [Reminder] = load(.reminders)
        else {
            fetchReminders()
            return
        }

        reminders = cachedReminders
    }

    func fetchReminders() {
        Task {
            do {
                reminders = try await service.fetchWithClients()
                    .sorted {
                    $0.id < $1.id
                }
                save(reminders, key: .reminders)
                for reminder in reminders {
                    print(reminder.complete)
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
                let reminder = try await service.fetch(id: id)
                updatedItem(reminder)
            }
        }
    }

    func idForSelectedRow(_ row: Int) -> Int {
        isFiltered ? filteredReminders[row].id : reminders[row].id
    }

    override func cachedItem(for id: Int) -> Any? {
        return reminders.first(where: { $0.id == id })
    }
}

// MARK: - Filterable

extension RemindersManager: Filterable {
    func toggleFilter() {
        isFiltered = !isFiltered
        updateDelegate()
    }
}

// MARK: - NSTableViewDelegate & NSTableViewDataSource

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
        isFiltered ? filteredReminders.count : reminders.count
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        delegate?.didSelect()
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard
            let tableColumn = tableColumn,
            let column = Column(rawValue: tableColumn.identifier.rawValue)
        else { return nil }

        let reminder = isFiltered ? filteredReminders[row] : reminders[row]

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
            view.textField?.stringValue = reminder.date?
            .formatted(date: .numeric, time: .omitted) ?? ""
        case .description:
            view.textField?.stringValue = reminder.description ?? ""
            view.toolTip = reminder.description ?? ""
        }

        view.layer?.opacity = reminder.complete ? 0.5 : 1.0

        return view
    }
}
