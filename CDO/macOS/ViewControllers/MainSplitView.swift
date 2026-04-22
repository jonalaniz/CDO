//
//  MainSplitView.swift
//  CDO
//
//  Created by Jon Alaniz on 10/21/25.
//

import Cocoa

final class MainSplitView: NSSplitViewController {
    private var sidebarItem: NSSplitViewItem
    var contentItem: NSSplitViewItem

    init(sidebar: NSViewController, content: NSViewController) {
        sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebar)
        contentItem = NSSplitViewItem(viewController: content)
        super.init(nibName: nil, bundle: nil)
        splitViewItems = [sidebarItem, contentItem]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContentItem() {

    }
}
