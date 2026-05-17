//
//  EmploymentProfile.swift
//  CDO
//
//  Created by Jon Alaniz on 5/15/26.
//

import Cocoa

final class EmploymentProfileItem: ClientCardItem {
    private let disabilityField = LabelPairView(header: "Disability")
    private let criminalChargesField = LabelPairView(header: "Criminal Charges")
    private let transportationField = LabelPairView(header: "Transportation")

    override func viewDidLoad() {
        let stackView = makeStackView(
            views: [
                disabilityField,
                criminalChargesField,
                transportationField
            ],
            orientation: .vertical,
            alignment: .leading,
            spacing: 8)

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    override func configure(with client: ClientDetail) {
        disabilityField.setContent(client.disability)
        criminalChargesField.setContent(client.criminalCharge)
        transportationField.setContent(client.transportation)
    }
}
