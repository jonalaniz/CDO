//
//  ReminderCell.swift
//  CDO
//
//  Created by Jon Alaniz on 5/9/26.
//

import Cocoa

final class ReminderCell: NSTableCellView {
    static var identifier = NSUserInterfaceItemIdentifier("ReminderCell")

    private var clientField = NSTextField(labelWithString: "")

    private var dateField = NSTextField(labelWithString: "")
    private var reminderField = NSTextField(labelWithString: "")
    private var id: Int?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        layer?.backgroundColor = NSColor.red.cgColor
        styleCell()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureWith(_ reminder: Reminder) {
        dateField.stringValue = reminder.date.formatted(
            date: .numeric,
            time: .omitted
        )
        clientField.stringValue = reminder.clientName ?? ""
        reminderField.stringValue = reminder.description
        id = reminder.id
    }

    private func styleCell() {
        clientField.font = NSFont.preferredFont(forTextStyle: .headline)
        clientField.textColor = .labelColor

        dateField.font = NSFont.preferredFont(forTextStyle: .headline)
        dateField.textColor = .secondaryLabelColor
        dateField.alignment = .right

        reminderField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        reminderField.font = NSFont.preferredFont(forTextStyle: .body)
        reminderField.maximumNumberOfLines = 0
        reminderField.lineBreakMode = .byWordWrapping
    }

    private func setupLayout() {
        let headerStack = NSStackView(views: [clientField, NSView(), dateField])
        headerStack.orientation = .horizontal
        headerStack.distribution = .fill

        let stackView = NSStackView(views: [headerStack, reminderField])
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let line = NSBox()
        line.boxType = .separator
        line.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        addSubview(line)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),

            line.heightAnchor.constraint(equalToConstant: 1),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
