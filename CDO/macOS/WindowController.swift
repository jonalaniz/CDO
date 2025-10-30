//
//  WindowController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/21/25.
//

import Cocoa

// TODO: The following items need to be set
// Source changing based on which source was picked
// Setting the buttons and search to those datamanagers based on source
// Confrom to protocol

class WindowController: NSWindowController {
    private var addButtomToolbarItem: NSToolbarItem?
    private var currentSource: SourceItem?
    private var currentItemCreationprovidingObject: ItemCreationProviding?

    override func windowDidLoad() {
        super.windowDidLoad()
        CDOCoordinator.shared.setWindowController(self)
        configureWindow()
        configureToolbar()
        updateSubtitle()
    }

    private func configureWindow() {
        guard
            let splitVC = window?.contentViewController as? NSSplitViewController,
            let inspectorItem = splitVC.splitViewItems.last
        else { return }

        inspectorItem.minimumThickness = 300
        inspectorItem.maximumThickness = 360
    }

    private func configureToolbar() {
        guard let window = window else { return }

        let newToolbar = NSToolbar(identifier: NSToolbar.Identifier.mainWindowToolbarIdentifier)
        newToolbar.delegate = self
        newToolbar.allowsUserCustomization = false
        newToolbar.displayMode = .iconOnly

        window.toolbarStyle = .unified
        window.toolbar = newToolbar
        window.toolbar?.validateVisibleItems()
        window.titlebarSeparatorStyle = .line

        // Create the search bar

    }

    private func updateSubtitle() {
        // here we will update based on our subtitle
    }

    func moveToNewView(_ source: SourceItem) {
        guard currentSource != source else { return }
        guard let splitVC = window?.contentViewController as? SplitViewController else {
            return
        }

        guard
            let controller = storyboard?.instantiateController(withIdentifier: source.rawValue
            ) as? NSViewController,
            let inspector = storyboard?.instantiateController(withIdentifier: source.inspectorIdentifier
            ) as? NSViewController
        else { return }

        // Remove split view items that are not sidebar
        for splitViewItem in splitVC.splitViewItems where splitViewItem != splitVC.sidebarItem {
            splitVC.removeSplitViewItem(splitViewItem)
        }

        let mainItem = NSSplitViewItem(viewController: controller)
        let inspectorItem = NSSplitViewItem(inspectorWithViewController: inspector)
        inspectorItem.minimumThickness = 300
        inspectorItem.maximumThickness = 360

        splitVC.insertSplitViewItem(mainItem, at: 1)
        splitVC.insertSplitViewItem(inspectorItem, at: 2)

        setNewItemProviding(for: source)
    }

    private func setNewItemProviding(for source: SourceItem) {
        switch source {
        case .clients: currentItemCreationprovidingObject =  ClientManager.shared
        default: return
        }
    }

    @objc private func newItemClicked(_ sender: NSToolbarItem) {
        guard
            let storyboard = storyboard,
            let popupController = currentItemCreationprovidingObject?.makeCreationViewController(using: storyboard)
        else { return }

        window?.contentViewController?.presentAsSheet(popupController)
    }
}

enum ItemCreationControllers {
    case client

    var identifier: NSStoryboard.SceneIdentifier {
        switch self {
        case .client: NSStoryboard.SceneIdentifier("NewClient")
        }
    }
}

extension ClientManager: ItemCreationProviding {
    func makeCreationViewController(using storyboard: NSStoryboard) -> NSViewController? {
        guard let controller = storyboard.instantiateController(withIdentifier: ItemCreationControllers.client.identifier)
                as? NSViewController
        else { return nil }
        return controller
    }
}

extension WindowController: NSToolbarDelegate {
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        if itemIdentifier == .newItem {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(newItemClicked)
            toolbarItem.label = "New"
            toolbarItem.toolTip = "New"
            toolbarItem.isBordered = true
            toolbarItem.image = NSImage(systemSymbolName: "plus", accessibilityDescription: "Add")
            addButtomToolbarItem = toolbarItem
            return toolbarItem
        }

        return nil
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            .flexibleSpace,
            .newItem,
            .inspectorTrackingSeparator,
            .flexibleSpace,
            .toggleInspector
        ]
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            .flexibleSpace,
            .newItem,
            .inspectorTrackingSeparator,
            .toggleInspector
        ]
    }
}

extension NSToolbar.Identifier {
    static let mainWindowToolbarIdentifier = NSToolbar.Identifier("MainWindowToolbar")
}

extension NSToolbarItem.Identifier {
    static let newItem = NSToolbarItem.Identifier("NewItem")
}
