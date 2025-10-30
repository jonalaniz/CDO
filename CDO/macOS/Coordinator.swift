//
//  Coordinator.swift
//  CDO
//
//  Created by Jon Alaniz on 10/20/25.
//

import Cocoa

final class CDOCoordinator: NSObject {
    // MARK: - Shared Instance

    static let shared = CDOCoordinator()

    // MARK: - Properties
    private let cacheManager = CacheManager.shared
    private let clientManager = ClientManager.shared
    private let remindersManager = RemindersManager.shared
    private let storyboard = NSStoryboard(name: "Main", bundle: nil)

    var splitViewController: NSSplitViewController?
    private var windowController: WindowController?

    private override init() {}

    func navigateToViewController(_ source: SourceItem) {
        guard let splitVC = splitViewController else {
            return
        }

        guard let destination = storyboard.instantiateController(
            withIdentifier: source.rawValue
        ) as? NSViewController
        else { return }

        // Remove the current detail item (if any)
        if splitVC.splitViewItems.count > 1 {
            let currentDetail = splitVC.splitViewItems[1]
            splitVC.removeSplitViewItem(currentDetail)
        }

        // Add the new one
        let newDetailItem = NSSplitViewItem(viewController: destination)
        splitVC.insertSplitViewItem(newDetailItem, at: 1)
    }

    func setWindowController(_ windowController: NSWindowController) {
        self.windowController = windowController as? WindowController
    }
}

extension CDOCoordinator: SidebarDelegate {
    func selectionMade(_ source: SourceItem) {
        windowController?.moveToNewView(source)
    }
}
