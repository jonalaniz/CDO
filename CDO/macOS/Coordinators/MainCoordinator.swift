//
//  Coordinator.swift
//  CDO
//
//  Created by Jon Alaniz on 10/20/25.
//

import Cocoa

final class CDOCoordinator: NSObject {
    static let shared = CDOCoordinator()

    // Child coordinators
    private var clientCoordinator: ClientCoordinator?

    private let cdo = CDO.shared
    private var mainSplitView: MainSplitView?
    private var sidebarController = SidebarViewController()
    private var window: NSWindow?

    private override init() {}

    func start() {
        guard ConfigurationManager.shared.isConfigured else {
            showLoginSheet()
            return
        }

        configureMainWindow()
    }

    private func setupViewControllers() {
        // I need to seed the
    }

    func showLoginSheet() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        if let modalVC = storyboard.instantiateController(withIdentifier: "SignInPage") as? NSViewController {
            mainSplitView?.presentAsSheet(modalVC)
        }
    }

    func navigateToViewController(_ source: SourceItem) {
        switch source {
        case .reminders: showReminders()
        case .clients: showClients()
        case .counselors: mainSplitView?.setContentItem(NSViewController())
        case .employers: mainSplitView?.setContentItem(NSViewController())
        case .sas: mainSplitView?.setContentItem(NSViewController())
        case .placements: mainSplitView?.setContentItem(NSViewController())
        default: return
        }
    }

    func showClients() {
        guard let manager = cdo.clientManager else { return }

        if clientCoordinator == nil {
            let coordinator = ClientCoordinator(
                manager: manager
            )
            coordinator.start()
            clientCoordinator = coordinator
        }

        mainSplitView?.setContentItem(clientCoordinator!.rootViewController)
        window?.toolbar?.delegate = clientCoordinator
        window?.toolbar?.reloadItems()
    }

    func showReminders() {
        mainSplitView?.setContentItem(NSViewController())
        window?.toolbar?.delegate = self
        window?.toolbar?.reloadItems()
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

// TODO: Move this
extension NSToolbar {
    func reloadItems() {
        for item in items {
            removeItem(identifier: item.itemIdentifier)
        }
        delegate?.toolbarAllowedItemIdentifiers?(self).enumerated().forEach { index, identifier in
            insertItem(withItemIdentifier: identifier, at: index)
        }
    }
}
