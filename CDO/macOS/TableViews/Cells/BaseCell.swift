//
//  BaseCell.swift
//  CDO
//
//  Created by Jon Alaniz on 5/9/26.
//

import Cocoa

class BaseCell<Model: Codable>: NSTableCellView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        styleCell()
        layoutCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func styleCell() {}

    func layoutCell() {}

    func configure(with item: Model) {}

    func applyHeadingStyle(
        field: NSTextField,
        alignment: NSTextAlignment = .natural,
        color: NSColor = .labelColor
    ) {
        field.font = .preferredFont(forTextStyle: .headline)
        field.alignment = alignment
        field.textColor = color
    }

    func applyBodyStyle(field: NSTextField) {
        field.font = .preferredFont(forTextStyle: .body)
        field.textColor = .labelColor
        field.lineBreakMode = .byWordWrapping
        field.maximumNumberOfLines = 0
    }

    func separator() -> NSBox {
        let separator = NSBox()
        separator.boxType = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }
}
