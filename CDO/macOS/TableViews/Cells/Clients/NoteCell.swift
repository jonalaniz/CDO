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
    private var authorField = NSTextField(labelWithString: "")
    private var id: Int?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        styleCell()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureWith(_ note: ClientNote) {
        dateField.stringValue = note.date.formatted(
            date: .numeric,
            time: .standard
        )
        authorField.stringValue = note.author ?? ""
        noteField.stringValue = note.note
        id = note.id
    }

    private func styleCell() {
        dateField.font = NSFont.preferredFont(forTextStyle: .headline)
        dateField.textColor = .secondaryLabelColor

        authorField.font = NSFont.preferredFont(forTextStyle: .headline)
        authorField.textColor = .controlAccentColor
        authorField.alignment = .right

        noteField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        noteField.font = NSFont.preferredFont(forTextStyle: .body)
        noteField.maximumNumberOfLines = 0
        noteField.lineBreakMode = .byWordWrapping
    }

    private func setupLayout() {
        let headerStack = NSStackView(views: [dateField, NSView(), authorField])
        headerStack.orientation = .horizontal
        headerStack.distribution = .fill

        let stackView = NSStackView(views: [headerStack, noteField])
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let line = NSBox()
        line.boxType = .separator
        line.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        addSubview(line)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),

            line.heightAnchor.constraint(equalToConstant: 1),
            line.leftAnchor.constraint(equalTo: leftAnchor),
            line.rightAnchor.constraint(equalTo: rightAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
