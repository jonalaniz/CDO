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

    // Child coordinators
    private var clientCoordinator: ClientCoordinator?

    private var mainSplitView: MainSplitView?
    private var sidebarController = SidebarViewController()
    private var remindersController: RemindersController?
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
            let coordinator = ClientCoordinator(manager: manager, toolbarProvider: self)
            coordinator.start()
            clientCoordinator = coordinator
        }

        guard let coordinator = clientCoordinator else { return }
        resizeWindowIfNeeded(coordinator.rootViewController.minimumWidth)
        setContent(coordinator.rootViewController, toolbarDelegate: coordinator)
    }

    func showReminders() {
        mainSplitView?.setContentItem(NSViewController())
        window?.toolbar?.delegate = self
        window?.toolbar?.reloadItems()
    }

    @objc func showRemindersPopover(_ sender: NSToolbarItem) {
        guard let controller = remindersController else { return }

        let popover = NSPopover()
        popover.contentViewController = controller
        popover.behavior = .transient
        popover.contentSize = .init(width: 300, height: 500)
        popover.show(relativeTo: sender)
    }

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

        // TODO: Configure the reminders controller
        remindersController = RemindersController()

    }

    private func resizeWindowIfNeeded(_ width: CGFloat) {
        guard
            let splitview = mainSplitView,
            let window = window
        else { return }

        let sidebar = splitview.splitViewItems[0]
        let minimum = sidebar.isCollapsed
        ? width : width + sidebar.maximumThickness

        guard window.frame.size.width < minimum else { return }

        sidebar.canCollapse = false

        var frame = window.frame
        frame.size.width = minimum

        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.25
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            window.animator().setFrame(frame, display: true)
        } completionHandler: {
            sidebar.canCollapse = true
        }
    }

    private func setContent(_ viewController: NSViewController, toolbarDelegate: NSToolbarDelegate) {
        mainSplitView?.setContentItem(viewController)
        window?.makeFirstResponder(viewController.view)
        window?.toolbar?.delegate = toolbarDelegate
        window?.toolbar?.reloadItems()
    }
}

extension CDOCoordinator: SidebarDelegate {
    func selectionMade(_ source: SourceItem) {
        navigateToViewController(source)
    }
}

extension CDOCoordinator: ToolbarItemProviding {
    func makeRemindersItem() -> NSToolbarItem {
        let item = NSToolbarItem(itemIdentifier: .remindersItem)
        item.action = #selector(showRemindersPopover)
        item.target = self
        item.visibilityPriority = .high
        item.isBordered = true
        item.image = NSImage(systemSymbolName: "checklist", accessibilityDescription: "Reminders")
        return item
    }
}
