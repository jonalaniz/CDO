//
//  WindowController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/21/25.
//

import Cocoa

// TODO: The following items need to be set
// Setting the buttons and search to those datamanagers based on source

class WindowController: NSWindowController {
    private var addButtomToolbarItem: NSToolbarItem?
    private var currentSource: SourceItem?
    private var currentItemCreationprovidingObject: ItemCreationProviding?
    private var filterableDataManager: Filterable?

    override func windowDidLoad() {
        super.windowDidLoad()
        CDOCoordinator.shared.setWindowController(self)
        configureWindow()
        configureToolbar()
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

        // By default, this is the first view.
        filterableDataManager = RemindersManager.shared

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

        splitVC.contentItem = mainItem

        splitVC.insertSplitViewItem(mainItem, at: 1)
        splitVC.inspectorItem = inspectorItem
        splitVC.addSplitViewItem(inspectorItem)

        configureCapabilities(for: source)
    }

    func updateInspectorRepresentedObject(with object: Any) {
        guard
            let splitVC = window?.contentViewController as? SplitViewController,
            let inspector = splitVC.inspectorItem
        else { return }

        inspector.viewController.representedObject = object
    }

    func updateSubtitle(with string: String) {
        window?.subtitle = string
    }

    private func configureCapabilities(for source: SourceItem) {
        switch source {
        case .clients:
            filterableDataManager = nil
            currentItemCreationprovidingObject =  ClientManager.shared
        case .reminders:
            filterableDataManager = RemindersManager.shared
            currentItemCreationprovidingObject = nil
            // Set the filtered button in the toolbar
        default: return
        }

        configureFilterButton()
    }

    private func configureFilterButton() {
        guard
            let toolbar = window?.toolbar,
            let filterButton = toolbar.items.first(where: { $0.itemIdentifier == .filterItem })
        else { return }

        guard let filterableDataManager = filterableDataManager else {
            filterButton.isHidden = true
            return
        }

        let isFiltered = filterableDataManager.isFiltered

        filterButton.isHidden = false
        filterButton.image = isFiltered
        ? NSImage(systemSymbolName: "line.3.horizontal.decrease.circle.fill", accessibilityDescription: "")
        : NSImage(systemSymbolName: "line.3.horizontal.decrease.circle", accessibilityDescription: "")
        filterButton.toolTip = isFiltered
        ? "Show all"
        : "Show only completed items"

    }

    @objc private func newItemClicked(_ sender: NSToolbarItem) {
        guard
            let storyboard = storyboard,
            let popupController = currentItemCreationprovidingObject?.makeCreationViewController(using: storyboard)
        else { return }

        window?.contentViewController?.presentAsSheet(popupController)
    }

    @objc private func filterButtonClicked(_ sender: NSToolbarItem) {
        filterableDataManager?.toggleFilter()
        configureFilterButton()
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
        guard let controller = storyboard.instantiateController(
            withIdentifier: ItemCreationControllers.client.identifier
        )
                as? NSViewController
        else { return nil }
        return controller
    }
}

extension WindowController: NSToolbarDelegate {
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
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

        if itemIdentifier == .filterItem {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(filterButtonClicked)
            toolbarItem.label = "Filter"
            toolbarItem.toolTip = "Show only completed items"
            toolbarItem.isBordered = true
            toolbarItem.image = NSImage(systemSymbolName: "line.3.horizontal.decrease.circle", accessibilityDescription: "")
            addButtomToolbarItem = toolbarItem
            return toolbarItem
        }

        return nil
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            .flexibleSpace,
            .filterItem,
            .newItem,
            .inspectorTrackingSeparator,
            .toggleInspector
        ]
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            .flexibleSpace,
            .filterItem,
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
    static let filterItem = NSToolbarItem.Identifier("FilterItem")
}
