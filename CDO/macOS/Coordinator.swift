//
//  Coordinator.swift
//  CDO
//
//  Created by Jon Alaniz on 10/20/25.
//

import Cocoa

final class CDOCoordinator: NSObject {
    static let shared = CDOCoordinator()

    private let cdo = CDO.shared
    private var splitViewController: NSSplitViewController?
    private var window: NSWindow?

    private override init() {}

    func start() {
        guard ConfigurationManager.shared.isConfigured else {
            showLoginSheet()
            return
        }

        configureMainWindow()
    }

    func showLoginSheet() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        if let modalVC = storyboard.instantiateController(withIdentifier: "SignInPage") as? NSViewController {
            splitViewController?.presentAsSheet(modalVC)
        }
    }

    func navigateToViewController(_ source: SourceItem) {
        guard let splitVC = splitViewController else {
            return
        }

        // Remove the current detail item (if any)
        if splitVC.splitViewItems.count > 1 {
            let currentDetail = splitVC.splitViewItems[1]
            splitVC.removeSplitViewItem(currentDetail)
        }
    }

    // MARK: - Utility Methods
    private func configureMainWindow() {
        let toolbar = NSToolbar(identifier: .mainWindowToolbarIdentifier)
//        toolbar.delegate = self
        toolbar.allowsUserCustomization = false
        toolbar.displayMode = .iconOnly

        window = WindowFactory.makeMainWindow()
        window?.title = "CDO"
        window?.toolbarStyle = .unified
        window?.toolbar = toolbar
        window?.toolbar?.validateVisibleItems()
        window?.titlebarSeparatorStyle = .line
        window?.makeKeyAndOrderFront(nil)
    }
}

extension CDOCoordinator: SidebarDelegate {
    func selectionMade(_ source: SourceItem) {
        print(source)
    }
}
