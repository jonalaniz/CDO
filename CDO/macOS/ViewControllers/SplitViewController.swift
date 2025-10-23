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
        setInspectorWidth()
    }

    // MARK: - Setup
    private func initializeSplitViews() {
        // Ensure we actually have 3 items
        guard splitViewItems.count == 3 else { return }

        sidebarItem = splitViewItems[0]
        contentItem = splitViewItems[1]
        inspectorItem = splitViewItems[2]
    }

    private func setInspectorWidth() {
        guard let inspector = inspectorItem else { return }
        // Configure inspector so it’s resizable and not too narrow
//        inspector.minimumThickness = 400
//        inspector.maximumThickness = 500
//        inspector.holdingPriority = .defaultLow // enables flexible resizing
//        inspector.canCollapse = true
    }
}
