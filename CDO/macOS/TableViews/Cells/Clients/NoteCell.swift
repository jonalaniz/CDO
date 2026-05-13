//
//  NoteCell.swift
//  CDO
//
//  Created by Jon Alaniz on 4/28/26.
//

import Cocoa

final class NoteCell: BaseCell<ClientNote> {
    static let identifier = NSUserInterfaceItemIdentifier("NoteCell")

    private var dateField = NSTextField(labelWithString: "")
    private var authorField = NSTextField(labelWithString: "")
    private var noteField = NSTextField(labelWithString: "")
    private(set) var id: Int?

    override func styleCell() {
        applyHeadingStyle(field: dateField)
        applyHeadingStyle(
            field: authorField,
            alignment: .right,
            color: .controlAccentColor)
        applyBodyStyle(field: noteField)

        noteField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    override func layoutCell() {
        let headerStack = NSStackView(views: [dateField, NSView(), authorField])
        headerStack.orientation = .horizontal
        headerStack.distribution = .fill

        headerStack.translatesAutoresizingMaskIntoConstraints = false
        noteField.translatesAutoresizingMaskIntoConstraints = false

        let line = separator()

        addSubview(headerStack)
        addSubview(noteField)
        addSubview(line)

        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            headerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: trailingAnchor),

            noteField.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 8),
            noteField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            noteField.leadingAnchor.constraint(equalTo: leadingAnchor),
            noteField.trailingAnchor.constraint(equalTo: trailingAnchor),

            line.heightAnchor.constraint(equalToConstant: 1),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    override func configure(with note: ClientNote) {
        dateField.stringValue = note.date.formatted(
            date: .numeric,
            time: .shortened
        )
        authorField.stringValue = note.author ?? ""
        noteField.stringValue = note.note
        id = note.id
    }
}
