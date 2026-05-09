//
//  ClientCell.swift
//  CDO
//
//  Created by Jon Alaniz on 4/22/26.
//

import Cocoa

final class ClientCell: NSTableCellView {
    static var identifier = NSUserInterfaceItemIdentifier("ClientCell")
    private var nameField = NSTextField(labelWithString: "")
    private var addressField = NSTextField(labelWithString: "")
    var id: Int?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        styleCell()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func styleCell() {
        nameField.font = NSFont.preferredFont(forTextStyle: .headline)
        addressField.font = NSFont.preferredFont(forTextStyle: .body)
        addressField.textColor = .secondaryLabelColor
    }

    private func setupLayout() {
        let stackview = NSStackView(views: [nameField, addressField])
        stackview.orientation = .vertical
        stackview.alignment = .leading
        stackview.distribution = .fill
        stackview.spacing = 3
        stackview.translatesAutoresizingMaskIntoConstraints = false

        let line = NSBox()
        line.boxType = .separator
        line.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackview)
        addSubview(line)

        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),

            line.heightAnchor.constraint(equalToConstant: 1),
            line.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            line.rightAnchor.constraint(equalTo: rightAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    public func configureClient(name: String, address: String, id: Int) {
        self.nameField.stringValue = name
        self.addressField.stringValue = address
        self.id = id
    }
}
