//
//  ClientCell.swift
//  CDO
//
//  Created by Jon Alaniz on 4/22/26.
//

import Cocoa

final class ClientCell: BaseCell<ClientSummary> {
    static let identifier = NSUserInterfaceItemIdentifier("ClientCell")

    private var nameField = NSTextField(labelWithString: "")
    private var addressField = NSTextField(labelWithString: "")
    private(set) var id: Int?

    override func styleCell() {
        applyHeadingStyle(field: nameField)
        applyBodyStyle(field: addressField)
    }

    override func layoutCell() {
        let stackView = NSStackView(views: [nameField, addressField])
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let line = separator()

        addSubview(stackView)
        addSubview(line)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),

            line.heightAnchor.constraint(equalToConstant: 1),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            line.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    override func configure(with client: ClientSummary) {
        nameField.stringValue = client.name
        addressField.stringValue = client.formattedAddress
        id = client.id
    }
}
