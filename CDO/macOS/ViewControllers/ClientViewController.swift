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

    // TODO: Make a base ViewController class and have this function be a default
    func updateSubtitle() {
        guard let window = view.window?.windowController as? WindowController
        else { return }
        let count = tableView.numberOfRows
        window.updateSubtitle(with: "\(count) Clients")
    }
}

extension ClientViewController: DataManagerDelegate {
    func didUpdateClients() {
        tableView.reloadData()
        updateSubtitle()
    }

    func didSelect() {
        let clientID = manager.clients[tableView.selectedRow].id
        manager.fetchClient(id: clientID)
    }
}
