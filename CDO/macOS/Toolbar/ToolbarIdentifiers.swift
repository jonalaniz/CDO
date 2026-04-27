//
//  ToolbarIdentifiers.swift
//  CDO
//
//  Created by Jon Alaniz on 4/25/26.
//

import Cocoa

extension NSToolbar.Identifier {
    static let mainWindowToolbarIdentifier = NSToolbar.Identifier("MainWindowToolbar")
}

// Contains shared toolbar items
extension NSToolbarItem.Identifier {
    static let newItem = NSToolbarItem.Identifier("newItem")
    static let filterItem = NSToolbarItem.Identifier("FilterItem")
    static let primaryTrackingSeparator = NSToolbarItem.Identifier("PrimaryTrackingSeparator")
    static let secondaryTrackingSeparator = NSToolbarItem.Identifier("SecondaryTrackingSeparator")
}
