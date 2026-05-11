//
//  ClientCard.swift
//  CDO
//
//  Created by Jon Alaniz on 5/11/26.
//

import Cocoa

enum ClientCard: Int, CaseIterable {
    case personal
    case contact
    case caseInfo
    case conditions
    case sas
    case employmentProfile
    case placements
    case checklist

    var title: String {
        switch self {
        case .personal: "Personal information"
        case .contact: "Contact Information"
        case .caseInfo: "Case Information"
        case .conditions: "Conditions"
        case .sas: "Service Authorizations"
        case .employmentProfile: "Employment Profile"
        case .placements: "Placements"
        case .checklist: "Checklist"
        }
    }
}

class ClientCardItem: NSCollectionViewItem {
    let glassView = NSGlassEffectView()
    let contentView = NSGlassEffectView()
    let button = NSButton(
        image: NSImage(systemSymbolName: "pencil", accessibilityDescription: "edit") ?? NSImage(),
        target: nil,
        action: nil
    )
    let titleLabel = NSTextField(labelWithString: "Test Title Label")
    let height = NSFont.preferredFont(forTextStyle: .title1).boundingRectForFont.height

    override func loadView() {
        layoutGlassView()
        constrainViews()
    }

    private func layoutGlassView() {
        view = NSView()
        view.addSubview(glassView)
        glassView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            glassView.topAnchor.constraint(equalTo: view.topAnchor),
            glassView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            glassView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            glassView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func constrainViews() {
        titleLabel.font = NSFont.systemFont(ofSize: 23, weight: .bold)
        button.bezelStyle = .glass
        button.borderShape = .circle

        contentView.style = .clear

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        glassView.addSubview(titleLabel)
        glassView.addSubview(button)
        glassView.addSubview(contentView)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: glassView.topAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: glassView.trailingAnchor, constant: -8),
            button.heightAnchor.constraint(equalToConstant: height),
            button.widthAnchor.constraint(equalToConstant: height),

            titleLabel.topAnchor.constraint(equalTo: glassView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: glassView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: height),

            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: glassView.bottomAnchor, constant: -8),
            contentView.leadingAnchor.constraint(equalTo: glassView.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: glassView.trailingAnchor, constant: -8)
        ])
    }
}
