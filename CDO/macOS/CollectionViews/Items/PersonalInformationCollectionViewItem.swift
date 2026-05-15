//
//  PersonalInformationCell.swift
//  CDO
//
//  Created by Jon Alaniz on 5/8/26.
//

import Cocoa

final class PersonalInformationCollectionViewItem: ClientCardItem {
    private let dobField = LabelPairView(header: "DOB")
    private let dlField = LabelPairView(header: "DL/ID")
    private let ssnField = LabelPairView(header: "SSN")
    private let languageField = LabelPairView(header: "Fluent Languages")
    private let raceField = LabelPairView(header: "Race")
    private let addressField = LabelPairView(header: "Address")
    private let educationField = LabelPairView(header: "Education")

    override func viewDidLoad() {
        let row0 = makeStackView(
            views: [dobField, dlField, ssnField],
            orientation: .horizontal,
            distribution: .fillEqually,
            spacing: 4)

        let row1 = makeStackView(
            views: [languageField, raceField],
            orientation: .horizontal,
            distribution: .fillEqually,
            spacing: 4)

        let stackView = makeStackView(
            views: [row0, row1, addressField, educationField],
            orientation: .vertical,
            alignment: .leading,
            spacing: 8)

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            row0.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            row1.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }

    func configure(with client: ClientDetail) {
        dobField.setContent(client.formattedDob)
        dlField.setContent(client.driversLicense)
        ssnField.setContent(client.formattedSSN)
        languageField.setContent(client.fluentLanguages)
        raceField.setContent(client.race)
        addressField.setContent(client.formattedAddress)
        educationField.setContent(client.education)
    }
}
