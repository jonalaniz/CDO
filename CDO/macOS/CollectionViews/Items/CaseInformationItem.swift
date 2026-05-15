//
//  CaseInformationItem.swift
//  CDO
//
//  Created by Jon Alaniz on 5/13/26.
//

import Cocoa

final class CaseInformationItem: ClientCardItem {
    private let startDateField = LabelPairView(header: "Start Date")
    private let caseIDField = LabelPairView(header: "Case ID")
    private let caseLoadField = LabelPairView(header: "Case Load")

    private let benefitsField = LabelPairView(header: "Benefits")
    private let premiumsField = LabelPairView(header: "Premiums")
    private let tierField = LabelPairView(header: "Tier")

    private let counselorField = LabelPairView(header: "Counselor")
    private let secretaryField = LabelPairView(header: "Secretary")

    override func viewDidLoad() {
        let row0 = makeStackView(
            views: [startDateField, caseIDField, caseLoadField],
            orientation: .horizontal,
            distribution: .fillEqually,
            spacing: 4)

        let row1 = makeStackView(
            views: [benefitsField, premiumsField, caseLoadField],
            orientation: .horizontal,
            distribution: .fillEqually,
            spacing: 4)

        let stackView = makeStackView(
            views: [row0, row1, counselorField, secretaryField],
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
        startDateField.setContent(client.formattedStartDate)
        caseIDField.setContent(client.caseID)
        caseLoadField.setContent(client.formattedCaseLoad)
        benefitsField.setContent(client.benefits)
        premiumsField.setContent(client.premiums)
        tierField.setContent(client.status)
        counselorField.setContent(client.formattedCounselor)
        secretaryField.setContent(client.formattedSecretary)
    }
}
