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
    private let inspectorViewItem: NSSplitViewItem

    private let minimumTableWidth: CGFloat = 250
    private let minimumContentWidth: CGFloat = 300
    private let minimumInspectorWidth: CGFloat = 250

    var minimumWidth: CGFloat {
        return inspectorViewItem.isCollapsed
        ? minimumTableWidth + minimumContentWidth
        : minimumTableWidth + minimumContentWidth + minimumInspectorWidth
    }

    init(tableView: NSViewController, content: NSViewController, inspector: NSViewController) {
        tableViewItem = NSSplitViewItem(
            viewController: tableView
        )
        contentViewItem = NSSplitViewItem(
            viewController: content
        )

        inspectorViewItem = NSSplitViewItem(
            inspectorWithViewController: inspector
        )

        super.init(nibName: nil, bundle: nil)
        setupSplitView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSplitView() {
        tableViewItem.minimumThickness = minimumTableWidth
        tableViewItem.maximumThickness = minimumTableWidth
        contentViewItem.minimumThickness = minimumContentWidth
        inspectorViewItem.minimumThickness = minimumInspectorWidth
        inspectorViewItem.maximumThickness = minimumInspectorWidth
        splitViewItems = [
            tableViewItem,
            contentViewItem,
            inspectorViewItem
        ]
    }
}
