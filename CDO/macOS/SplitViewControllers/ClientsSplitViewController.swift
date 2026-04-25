//
//  ClientsSplitViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 4/22/26.
//

import Cocoa

final class ClientSplitViewController: NSSplitViewController {
    private let tableViewItem: NSSplitViewItem
    private let contentViewItem: NSSplitViewItem
    init(tableView: NSViewController, content: NSViewController) {
        tableViewItem = NSSplitViewItem(
            viewController: tableView
        )
        contentViewItem = NSSplitViewItem(
            viewController: content
        )

        super.init(nibName: nil, bundle: nil)
        setupSplitView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSplitView() {
        tableViewItem.minimumThickness = 250
        tableViewItem.maximumThickness = 250
        contentViewItem.minimumThickness = 300
        splitViewItems = [
            tableViewItem,
            contentViewItem
        ]
    }
}
