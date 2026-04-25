//
//  MainSplitView.swift
//  CDO
//
//  Created by Jon Alaniz on 10/21/25.
//

import Cocoa

final class MainSplitView: NSSplitViewController {
    private let sidebarItem: NSSplitViewItem
    private var contentItem: NSSplitViewItem

    init(sidebar: NSViewController, content: NSViewController) {
        sidebarItem = NSSplitViewItem(
            sidebarWithViewController: sidebar
        )
        contentItem = NSSplitViewItem(
            viewController: content
        )
        super.init(nibName: nil, bundle: nil)
        setupSplitView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSplitView() {
        sidebarItem.minimumThickness = 220
        sidebarItem.maximumThickness = 220
        splitViewItems = [sidebarItem, contentItem]

    }

    func setContentItem(_ viewController: NSViewController) {
        let splitViewItem = NSSplitViewItem(viewController: viewController)
        removeSplitViewItem(contentItem)
        addSplitViewItem(splitViewItem)
        contentItem = splitViewItem
    }
}
