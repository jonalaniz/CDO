//
//  ConditionsItem.swift
//  CDO
//
//  Created by Jon Alaniz on 5/15/26.
//

import Cocoa

final class ConditionsItem: ClientCardItem {
    private let employmentGoalsField = LabelPairView(header: "Employment Goals")
    private let conditionsField = LabelPairView(header: "Conditions")

    override func viewDidLoad() {
        let stackView = makeStackView(
            views: [employmentGoalsField, conditionsField],
            orientation: .vertical,
            alignment: .leading,
            spacing: 8)

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    override func configure(with client: ClientDetail) {
        employmentGoalsField.setContent(client.employmentGoal)
        conditionsField.setContent(client.conditions)
    }
}
