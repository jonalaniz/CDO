//
//  ClientSACell.swift
//  CDO
//
//  Created by Jon Alaniz on 5/16/26.
//

import Cocoa

final class ClientSACell: BaseCell<SADetail> {
    static let identifier = NSUserInterfaceItemIdentifier("ClientSACell")
    static var height: CGFloat {
        let headerHeight = NSFont.heightFor(preferredFont: .headline)
        let descriptionHeight = NSFont.heightFor(preferredFont: .body)
        return headerHeight + descriptionHeight + 21
    }

    private var saNumberField = NSTextField(labelWithString: "")
    private var validTillField = NSTextField(labelWithString: "")
    private var descriptionField = NSTextField(labelWithString: "")
    private(set) var id: Int?

    override func styleCell() {
        applyHeadingStyle(field: saNumberField)
        applyHeadingStyle(field: validTillField, alignment: .right)
        applyBodyStyle(field: descriptionField)
    }

    override func layoutCell() {
        let headerStack = NSStackView(views: [saNumberField, validTillField])
        headerStack.orientation = .horizontal
        headerStack.distribution = .fill

        headerStack.translatesAutoresizingMaskIntoConstraints = false
        descriptionField.translatesAutoresizingMaskIntoConstraints = false

        let line = separator()

        addSubview(headerStack)
        addSubview(descriptionField)
        addSubview(line)

        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            headerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: trailingAnchor),

            descriptionField.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 4),
            descriptionField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            descriptionField.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionField.trailingAnchor.constraint(equalTo: trailingAnchor),

            line.heightAnchor.constraint(equalToConstant: 1),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    override func configure(with item: SADetail) {
        saNumberField.stringValue = item.serviceAuthorizationNumber
        validTillField.stringValue = item.formattedEndDate
        descriptionField.stringValue = item.description
        id = item.id
    }
}
