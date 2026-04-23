//
//  ClientsSplitViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 4/22/26.
//

import Cocoa

final class ClientSplitViewController: NSSplitViewController {
    private let clientsTableViewItem: NSSplitViewItem
    private let clientsContentItem: NSSplitViewItem
    init() {
        clientsTableViewItem = NSSplitViewItem(
            viewController: ClientsTableViewController()
        )
        clientsContentItem = NSSplitViewItem(
            viewController: ClientViewController()
        )

        super.init(nibName: nil, bundle: nil)
        setupSplitView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSplitView() {
        clientsTableViewItem.minimumThickness = 220
        clientsTableViewItem.maximumThickness = 220
        splitViewItems = [
            clientsTableViewItem,
            clientsContentItem
        ]
    }
}
