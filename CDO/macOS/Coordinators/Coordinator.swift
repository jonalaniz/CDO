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
        switch source {
        case .reminders: mainSplitView?.setContentItem(NSViewController())
        case .clients: mainSplitView?.setContentItem(clientSplitViewController)
        case .counselors: mainSplitView?.setContentItem(NSViewController())
        case .employers: mainSplitView?.setContentItem(NSViewController())
        case .sas: mainSplitView?.setContentItem(NSViewController())
        case .placements: mainSplitView?.setContentItem(NSViewController())
        default: return
        }
    }

    // MARK: - Utility Methods
    private func configureMainWindow() {
        // Configure the SplitViews
        mainSplitView = MainSplitView(
            sidebar: sidebarController,
            content: NSViewController()
        )

        // Configure the toolbar
        let toolbar = NSToolbar(identifier: .mainWindowToolbarIdentifier)
        toolbar.delegate = self
        toolbar.allowsUserCustomization = false
        toolbar.displayMode = .iconOnly

        // Create the Window and add the split views
        window = WindowFactory.makeMainWindow()
        window?.contentViewController = mainSplitView
        window?.toolbar = toolbar
        window?.toolbar?.validateVisibleItems()
        window?.makeKeyAndOrderFront(nil)
    }
}

extension CDOCoordinator: SidebarDelegate {
    func selectionMade(_ source: SourceItem) {
        navigateToViewController(source)
    }
}
