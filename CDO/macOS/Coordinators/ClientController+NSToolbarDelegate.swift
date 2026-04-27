//
//  ClientController+NSToolbarDelegate.swift
//  CDO
//
//  Created by Jon Alaniz on 4/26/26.
//

import Cocoa

extension NSToolbarItem.Identifier {
    // Client View Buttons
    static let documents = NSToolbarItem.Identifier("Documents")
    static let newReminder = NSToolbarItem.Identifier("NewReminder")
    static let clientMore = NSToolbarItem.Identifier("ClientMore")

    // Notes Inspector Buttons
    static let newNote = NSToolbarItem.Identifier("NewNote")
    static let notesMore = NSToolbarItem.Identifier("NotesMore")
    static let saveNote = NSToolbarItem.Identifier("SaveNote")
    static let notesMoreMenu = NSToolbarItem.Identifier("NotesMoreMenu")
}

extension ClientCoordinator: NSToolbarDelegate {
    func toolbar(
        _ toolbar: NSToolbar,
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        willBeInsertedIntoToolbar flag: Bool
    ) -> NSToolbarItem? {
        let item: NSToolbarItem
        item = NSToolbarItem(itemIdentifier: itemIdentifier)
        item.target = self

        switch itemIdentifier {
        case .newItem:
            item.action = #selector(newClient)
            item.toolTip = "New Client"
            item.visibilityPriority = .high
            item.isBordered = true
            item.image = NSImage(systemSymbolName: "plus",
                                 accessibilityDescription: "")
            return item
        case .primaryTrackingSeparator:
            return NSTrackingSeparatorToolbarItem(
                identifier: itemIdentifier,
                splitView: rootViewController.splitView,
                dividerIndex: 0
            )
        case .secondaryTrackingSeparator:
            return NSTrackingSeparatorToolbarItem(
                identifier: itemIdentifier,
                splitView: rootViewController.splitView,
                dividerIndex: 1
            )
        case .documents:
            item.action = #selector(openDocuments)
            item.toolTip = "Open Documents Folder"
            item.visibilityPriority = .standard
            item.isBordered = true
            item.image = NSImage(
                systemSymbolName: "folder",
                accessibilityDescription: ""
            )
            return item
        case .newReminder:
            item.action = #selector(newReminder)
            item.toolTip = "New Note"
            item.visibilityPriority = .standard
            item.isBordered = true
            item.image = NSImage(
                systemSymbolName: "calendar.badge.plus",
                accessibilityDescription: ""
            )
            return item
        case .clientMore:
            let moreItem = NSMenuToolbarItem(itemIdentifier: itemIdentifier)
            moreItem.showsIndicator = true
            moreItem.menu = makeMoreMenu()
            moreItem.toolTip = "More"
            moreItem.isBordered = true
            moreItem.image = NSImage(
                systemSymbolName: "ellipsis.circle",
                accessibilityDescription: ""
            )
            return moreItem
        case .newNote:
            item.action = #selector(newNote)
            item.label = "New Note"
            item.paletteLabel = "New Note"
            item.visibilityPriority = .low
            item.isBordered = true
            item.image = NSImage(
                systemSymbolName: "document.badge.plus",
                accessibilityDescription: ""
            )
            return item
        default: return nil
        }
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            .flexibleSpace,
            .toggleSidebar,
            .sidebarTrackingSeparator,
            .flexibleSpace,
            .newItem,
            .primaryTrackingSeparator,
            .flexibleSpace,
            .documents,
            .newReminder,
            .clientMore,
            .inspectorTrackingSeparator,
            .flexibleSpace,
            .newNote,
            .space,
            .toggleInspector
        ]
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }

    private func makeMoreMenu() -> NSMenu {
        let menu = NSMenu(title: "")
        let edit = NSMenuItem(title: "Edit", action: nil, keyEquivalent: "e")
        let toggleActive = NSMenuItem(title: "Toggle Active", action: nil, keyEquivalent: "t")
        let delete = NSMenuItem(title: "Delete", action: nil, keyEquivalent: "d")
        menu.items = [edit, toggleActive, .separator(), delete]
        return menu
    }
}
