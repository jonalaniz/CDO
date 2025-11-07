//
//  SplitViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/21/25.
//

import Cocoa

final class SplitViewController: NSSplitViewController {
    var sidebarItem: NSSplitViewItem?
    var contentItem: NSSplitViewItem?
    var inspectorItem: NSSplitViewItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        CDOCoordinator.shared.splitViewController = self
        initializeSplitViews()
    }

    // MARK: - Setup
    private func initializeSplitViews() {
        // Ensure we actually have 3 items
        guard splitViewItems.count == 3 else { return }

        sidebarItem = splitViewItems[0]
        contentItem = splitViewItems[1]
        inspectorItem = splitViewItems[2]
    }

    // TODO: Implement this
    func updateItems(contentItem: NSSplitViewItem, inspectorItem: NSSplitViewItem) {
        for splitViewItem in splitViewItems where splitViewItem != sidebarItem {
            removeSplitViewItem(splitViewItem)
        }
        self.contentItem = contentItem
        self.inspectorItem = inspectorItem
        addSplitViewItem(contentItem)
        addSplitViewItem(inspectorItem)
    }
}
