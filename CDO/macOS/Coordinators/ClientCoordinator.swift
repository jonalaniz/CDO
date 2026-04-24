//
//  ClientCoordinator.swift
//  CDO
//
//  Created by Jon Alaniz on 4/23/26.
//

import Cocoa

// MARK: TODO: Make this a delegate to ClientManager
final class ClientCoordinator: NSObject {
    private let manager: ClientManager
    private let tableViewController: ClientsTableViewController
    private let contentViewController: ClientViewController

    let rootViewController: ClientSplitViewController

    init(manager: ClientManager) {
        self.manager = manager
        tableViewController = ClientsTableViewController()
        contentViewController = ClientViewController()

        rootViewController = ClientSplitViewController(
            tableView: tableViewController,
            content: contentViewController
        )

        super.init()
        self.manager.delegate = self
    }

    func start() {
        tableViewController.tableView.delegate = manager
        tableViewController.tableView.dataSource = manager
    }
}

extension ClientCoordinator: ClientManagerDelegate {
    func summariesDidChange() {
        tableViewController.tableView.reloadData()
    }

    func summaryWasAdded(_ summary: ClientSummary) {
        // insert summary into table view
    }

    func detailDidChange(_ item: ClientDetail?) {
        guard let client = item else {
            // contentController.clearClient()
            return
        }

        contentViewController.setClient(client)
    }

    func itemWasDeleted(id: Int) {
        // To be continued
    }

}
