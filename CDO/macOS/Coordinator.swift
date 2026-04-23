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
    private var mainSplitView: MainSplitView?
    private var sidebarController = SidebarViewController()
    private var clientSplitViewController = ClientSplitViewController()
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
            mainSplitView?.presentAsSheet(modalVC)
        }
    }

    func navigateToViewController(_ source: SourceItem) {
    }

    // MARK: - Utility Methods
    private func configureMainWindow() {
        // Configure the SplitViews

        sidebarController = SidebarViewController()

        mainSplitView = MainSplitView(
            sidebar: sidebarController,
            content: clientSplitViewController
        )

        // Configure the toolbar
        // TODO: Update and make this actually work
        let toolbar = NSToolbar(identifier: .mainWindowToolbarIdentifier)
//        toolbar.delegate = self
        toolbar.allowsUserCustomization = false
        toolbar.displayMode = .iconOnly

        // Create the Window and add the split views
        // TODO: Set the MainSplitView as the main content view

        window = WindowFactory.makeMainWindow()
        window?.contentViewController = mainSplitView
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
