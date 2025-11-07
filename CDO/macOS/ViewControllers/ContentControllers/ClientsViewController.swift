//
//  ClientsViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/13/25.
//

import Cocoa

class ClientsViewController: BaseContentViewController {
    @IBOutlet weak var tableView: NSTableView!

    private let manager = ClientManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = manager
        tableView.delegate = manager
        manager.delegate = self
        manager.fetchClientSummaries()
    }
}

extension ClientsViewController: DataManagerDelegate {
    func didUpdateItem(_ item: Any) {
        selectedObjectToRepresent(item)
    }

    func didUpdateItems() {
        tableView.reloadData()
        updateSubtitle(with: "\(tableView.numberOfRows) Clients")
    }

    func didSelect() {
        let id = manager.clientSummaries[tableView.selectedRow].id
        manager.fetchClient(id: id)

        // Checked for cached object to send to our inpector
        guard let cachedItem = manager.cachedItem(for: id)
        else { return }
        selectedObjectToRepresent(cachedItem)
    }
}
