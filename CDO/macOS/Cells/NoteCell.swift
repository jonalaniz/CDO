//
//  NoteCell.swift
//  CDO
//
//  Created by Jon Alaniz on 4/28/26.
//

import Cocoa

final class NoteCell: NSTableCellView {
    static var identifier = NSUserInterfaceItemIdentifier("NoteCell")

    private var dateField = NSTextField(labelWithString: "")
    private var noteField = NSTextField(labelWithString: "")
    private var id: Int?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        styleCell()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureNote(_ note: ClientNote) {
        dateField.stringValue = note.date.formatted(
            date: .numeric,
            time: .standard
        )
        noteField.stringValue = note.note
        id = note.id
    }

    private func styleCell() {
        dateField.font = NSFont.preferredFont(forTextStyle: .headline)
        dateField.textColor = .secondaryLabelColor
        noteField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        noteField.font = NSFont.preferredFont(forTextStyle: .body)
        noteField.maximumNumberOfLines = 0
        noteField.lineBreakMode = .byWordWrapping
    }

    private func setupLayout() {
        let stack = NSStackView(views: [dateField, noteField])
        stack.orientation = .vertical
        stack.alignment = .leading
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
