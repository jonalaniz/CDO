//
//  RemindersManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import AppKit

final class RemindersManager: NSObject {
    weak var delegate: (any ClientManagerDelegate)?
    private let service: ReminderService
    private var reminders = [Reminder]()

    private var filteredReminders: [Reminder] {
        reminders.filter { !$0.complete }
    }

    init(service: ReminderService) {
        self.service = service
        super.init()
        fetchReminders()
    }

    // MARK: - Public API
    func fetchReminders() {
        Task {
            do {
                reminders = try await service.fetchAll()
                    .sorted {
                    $0.date < $1.date
                }

                for reminder in reminders {
                    print(reminder.complete)
                }
            } catch {
                print(error)
            }
        }
    }

    func fetchReminder(id: Int) {
        Task {
            do {
                let reminder = try await service.fetch(id: id)
            }
        }
    }
}

// MARK: - NSTableViewDelegate & NSTableViewDataSource

extension RemindersManager: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        reminders.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(
            withIdentifier: ReminderCell.identifier,
            owner: self
        ) as? ReminderCell ?? ReminderCell()

        let reminder = reminders[row]
        cell.configure(with: reminder)

        return cell
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
//        delegate?.didSelect()
    }
}
