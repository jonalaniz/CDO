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
        let row0 = NSStackView(views: [dobField, dlField, ssnField])
        row0.orientation = .horizontal
        row0.distribution = .fillEqually
        row0.spacing = 4
        row0.translatesAutoresizingMaskIntoConstraints = false

        let row1 = NSStackView(views: [languageField, raceField])
        row1.orientation = .horizontal
        row1.distribution = .fillEqually
        row1.spacing = 4
        row1.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView(views: [row0, row1, addressField, educationField])
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

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
