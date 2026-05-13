//
//  ReminderCell.swift
//  CDO
//
//  Created by Jon Alaniz on 5/9/26.
//

import Cocoa

final class ReminderCell: BaseCell<Reminder> {
    static let identifier = NSUserInterfaceItemIdentifier("ReminderCell")

    private var clientField = NSTextField(labelWithString: "")
    private var dateField = NSTextField(labelWithString: "")
    private var reminderField = NSTextField(labelWithString: "")
    private(set) var id: Int?

    override func styleCell() {
        applyHeadingStyle(field: clientField)
        applyHeadingStyle(
            field: dateField,
            alignment: .right,
            color: .secondaryLabelColor)
        applyBodyStyle(field: reminderField)

        reminderField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    override func layoutCell() {
        let headerStack = NSStackView(views: [clientField, NSView(), dateField])
        headerStack.orientation = .horizontal
        headerStack.distribution = .fill

        let stackView = NSStackView(views: [headerStack, reminderField])
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let line = separator()

        addSubview(stackView)
        addSubview(line)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            line.heightAnchor.constraint(equalToConstant: 1),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    override func configure(with reminder: Reminder) {
        dateField.stringValue = reminder.formattedDate
        clientField.stringValue = reminder.clientName ?? ""
        reminderField.stringValue = reminder.description
        id = reminder.id
    }
}

