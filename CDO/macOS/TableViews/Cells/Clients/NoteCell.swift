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
    private var noteField = NSTextField(labelWithString: "")
    private var authorField = NSTextField(labelWithString: "")
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

    override func setupLayout() {
        let headerStack = NSStackView(views: [dateField, NSView(), authorField])
        headerStack.orientation = .horizontal
        headerStack.distribution = .fill

        let stackView = NSStackView(views: [headerStack, noteField])
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let line = separator()

        addSubview(stackView)
        addSubview(line)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),

            line.heightAnchor.constraint(equalToConstant: 1),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    override func configure(with note: ClientNote) {
        dateField.stringValue = note.date.formatted(
            date: .numeric,
            time: .standard
        )
        authorField.stringValue = note.author ?? ""
        noteField.stringValue = note.note
        id = note.id
    }
}
