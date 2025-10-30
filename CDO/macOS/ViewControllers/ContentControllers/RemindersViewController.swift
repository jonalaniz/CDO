//
//  RemindersViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import Cocoa

final class RemindersViewController: BaseContentViewController {
    @IBOutlet weak var tableView: NSTableView!

    private let manager = RemindersManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = manager
        tableView.delegate = manager
        manager.delegate = self
        manager.fetchReminders()
    }
}

extension RemindersViewController: DataManagerDelegate {
    func didUpdateItem(_ item: Any) {
        selectedObjectToRepresent(item)
    }

    func didUpdateItems() {
        tableView.reloadData()
        updateSubtitle(with: "\(tableView.numberOfRows) Reminders")
    }

    func didSelect() {
        let id = manager.idForSelectedRow(tableView.selectedRow)
        manager.fetchReminder(id: id)

        guard let cachedItem = manager.cachedItem(for: id)
        else { return }
        selectedObjectToRepresent(cachedItem)
    }
}
