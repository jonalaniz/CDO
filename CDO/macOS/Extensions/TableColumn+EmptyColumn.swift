//
//  TableColumn+EmptyColumn.swift
//  CDO
//
//  Created by Jon Alaniz on 5/8/26.
//

import Cocoa

extension NSTableColumn {
    static var emptyColumn: NSTableColumn {
        let column = NSTableColumn()
        column.title = ""
        return column
    }
}
