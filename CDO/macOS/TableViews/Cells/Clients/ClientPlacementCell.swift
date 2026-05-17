//
//  ClientPlacementCell.swift
//  CDO
//
//  Created by Jon Alaniz on 5/17/26.
//

import Cocoa

class ClientPlacementCell: BaseCell<PlacementDetail> {
    static let identifier = NSUserInterfaceItemIdentifier("ClientPlacementCell")
    static var height: CGFloat {
        let headerHeight = NSFont.heightFor(preferredFont: .headline)
        let bodyHeight = NSFont.heightFor(preferredFont: .body)
        return headerHeight + bodyHeight + bodyHeight + 21
    }

    private var employerField = NSTextField(labelWithString: "")
    private var positionField = NSTextField(labelWithString: "")
    private var placementDateField = NSTextField(labelWithString: "")
    private(set) var id: Int?

    override func styleCell() {
        applyHeadingStyle(field: employerField)
        applyBodyStyle(field: positionField)
        applyBodyStyle(field: placementDateField)
    }

    override func layoutCell() {
        employerField.translatesAutoresizingMaskIntoConstraints = false
        positionField.translatesAutoresizingMaskIntoConstraints = false
        placementDateField.translatesAutoresizingMaskIntoConstraints = false

        let line = separator()

        addSubview(employerField)
        addSubview(positionField)
        addSubview(placementDateField)
        addSubview(line)

        NSLayoutConstraint.activate([
            employerField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            employerField.leadingAnchor.constraint(equalTo: leadingAnchor),
            employerField.trailingAnchor.constraint(equalTo: trailingAnchor),

            positionField.topAnchor.constraint(equalTo: employerField.bottomAnchor, constant: 4),
            positionField.leadingAnchor.constraint(equalTo: leadingAnchor),
            positionField.trailingAnchor.constraint(equalTo: trailingAnchor),

            placementDateField.topAnchor.constraint(equalTo: positionField.bottomAnchor),
            placementDateField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            placementDateField.leadingAnchor.constraint(equalTo: leadingAnchor),
            placementDateField.trailingAnchor.constraint(equalTo: trailingAnchor),

            line.heightAnchor.constraint(equalToConstant: 1),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    override func configure(with item: PlacementDetail) {
        employerField.stringValue = item.employerName ?? ""
        positionField.stringValue = item.position ?? ""
        placementDateField.stringValue = item.formattedHireDate
    }
}
