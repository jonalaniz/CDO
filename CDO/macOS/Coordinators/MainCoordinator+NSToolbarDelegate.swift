//
//  MainCoordinator+NSToolbarDelegate.swift
//  CDO
//
//  Created by Jon Alaniz on 4/23/26.
//

import Cocoa

extension CDOCoordinator: NSToolbarDelegate {
    @objc func addClicked() {
        print("add clicked")
    }

    func toolbar(
        _ toolbar: NSToolbar,
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        willBeInsertedIntoToolbar flag: Bool
    ) -> NSToolbarItem? {
        if itemIdentifier == .newItem {
            let item =  NSToolbarItem(itemIdentifier: itemIdentifier)
            item.target = self
            item.action = #selector(addClicked)
            item.label = "New"
            item.paletteLabel = "New"
            item.visibilityPriority = .high
            item.isBordered = true
            item.image = NSImage(systemSymbolName: "plus", accessibilityDescription: "")
            return item
        }

        return nil
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            .flexibleSpace,
            .toggleSidebar,
            .sidebarTrackingSeparator,
            .flexibleSpace,
            .toggleInspector
        ]
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            .flexibleSpace,
            .toggleSidebar,
            .sidebarTrackingSeparator,
            .flexibleSpace,
            .toggleInspector
        ]
    }
}
