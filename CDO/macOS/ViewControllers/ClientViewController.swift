//
//  ClientViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/13/25.
//

import Cocoa

class ClientViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!

    private let manager = ClientManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = manager
        tableView.delegate = manager
        manager.delegate = self
        manager.fetchClients()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ClientViewController: DataManagerDelegate {
    func didUpdateClients() {
        tableView.reloadData()
    }
}
