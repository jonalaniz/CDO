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
}

extension RemindersViewController: DataManagerDelegate {
    func didUpdateClients() {
        tableView.reloadData()
    }

    func didSelect() {
        // Run selection code here
    }
}
