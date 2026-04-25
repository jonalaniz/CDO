//
//  NSToolbar+ReloadItems.swift
//  CDO
//
//  Created by Jon Alaniz on 4/25/26.
//

import Cocoa

extension NSToolbar {
    func reloadItems() {
        for item in items {
            removeItem(identifier: item.itemIdentifier)
        }

        delegate?.toolbarAllowedItemIdentifiers?(self).enumerated().forEach { index, identifier in
            insertItem(withItemIdentifier: identifier, at: index)
        }

        validateVisibleItems()
    }
}
