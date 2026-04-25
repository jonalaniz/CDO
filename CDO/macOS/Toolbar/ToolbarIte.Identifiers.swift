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

extension NSToolbarItem.Identifier {
    static let addItem = NSToolbarItem.Identifier("AddItem")
    static let filterItem = NSToolbarItem.Identifier("FilterItem")
    static let primaryTrackingSeparator = NSToolbarItem.Identifier("PrimaryTrackingSeparator")
    static let secondaryTrackingSeparator = NSToolbarItem.Identifier("SecondaryTrackingSeparator")
}
