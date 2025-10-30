//
//  RemindersViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import Cocoa

class RemindersViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!

    private let manager = RemindersManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = manager
        tableView.delegate = manager
        manager.delegate = self
        manager.fetchReminders()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func updateSubtitle() {
        guard let window = view.window?.windowController as? WindowController
        else { return }
        let count = tableView.numberOfRows
        window.updateSubtitle(with: "\(count) Reminders")
    }
}

extension RemindersViewController: DataManagerDelegate {
    func didUpdateClients() {
        tableView.reloadData()
        updateSubtitle()
    }

    func didSelect() {
        // Run selection code here
    }
}
