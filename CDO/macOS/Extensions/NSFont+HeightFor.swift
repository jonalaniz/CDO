//
//  NSFont+HeightFor.swift
//  CDO
//
//  Created by Jon Alaniz on 5/17/26.
//

import AppKit

extension NSFont {
    static func heightFor(preferredFont font: NSFont.TextStyle) -> CGFloat {
        return NSFont.preferredFont(forTextStyle: font).boundingRectForFont.height
    }
}
