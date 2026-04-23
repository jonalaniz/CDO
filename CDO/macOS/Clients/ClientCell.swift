//
//  ClientCell.swift
//  CDO
//
//  Created by Jon Alaniz on 4/22/26.
//

import Cocoa

final class ClientCell: NSTableCellView {
    static var identifier = NSUserInterfaceItemIdentifier("ClientCell")
    private var clientName = NSTextField(labelWithString: "")
    private var address = NSTextField(labelWithString: "")

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        styleCell()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func styleCell() {
        clientName.font = NSFont.preferredFont(forTextStyle: .headline)
        address.font = NSFont.preferredFont(forTextStyle: .body)
        address.textColor = .secondaryLabelColor
    }

    private func setupLayout() {
        let stackview = NSStackView()
        stackview.orientation = .vertical
        stackview.alignment = .leading
        stackview.distribution = .fill
        stackview.spacing = 4

        stackview.addArrangedSubview(clientName)
        stackview.addArrangedSubview(address)

        stackview.translatesAutoresizingMaskIntoConstraints = false

        let line = NSBox()
        line.boxType = .separator
        line.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackview)
        addSubview(line)

        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            line.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            line.rightAnchor.constraint(equalTo: rightAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    public func setLabels(name: String, address: String) {
        clientName.stringValue = name
        self.address.stringValue = address
    }
}
