//
//  ContactInformationItem.swift
//  CDO
//
//  Created by Jon Alaniz on 5/14/26.
//

import Cocoa

final class ContactInformationItem: ClientCardItem {
    private let phone1Field = LabelPairView(header: "Phone 1")
    private let phone2Field = LabelPairView(header: "Phone 2")
    private let phone3Field = LabelPairView(header: "Phone 3")
    private let email1Field = LabelPairView(header: "Email 1")
    private let email2Field = LabelPairView(header: "Email 2")

    private let phoneIcon = NSImageView(image: NSImage(
        systemSymbolName: "phone",
        accessibilityDescription: "Phone")!)
    private let emailIcon = NSImageView(image: NSImage(
        systemSymbolName: "mail",
        accessibilityDescription: "Email")!)

    override func viewDidLoad() {
        let phoneStackView = makeStackView(
            views: [phone1Field, phone2Field, phone3Field],
            orientation: .vertical,
            alignment: .leading,
            spacing: 8)

        let emailStackView = makeStackView(
            views: [email1Field, email2Field],
            orientation: .vertical,
            alignment: .leading,
            spacing: 8)

        let row0 = makeStackView(
            views: [phoneIcon, phoneStackView],
            orientation: .horizontal,
            alignment: .top,
            spacing: 8)

        let row1 = makeStackView(
            views: [emailIcon, emailStackView],
            orientation: .horizontal,
            alignment: .top,
            spacing: 8)

        let stackView = makeStackView(
            views: [row0, row1],
            orientation: .vertical,
            spacing: 8)

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            phoneIcon.heightAnchor.constraint(equalToConstant: 20),
            phoneIcon.widthAnchor.constraint(equalToConstant: 20),
            emailIcon.heightAnchor.constraint(equalToConstant: 20),
            emailIcon.widthAnchor.constraint(equalToConstant: 20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            row0.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            row1.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }

    override func configure(with client: ClientDetail) {
        phone1Field.setContent(client.phone1, header: client.phone1Identity)
        phone2Field.setContent(client.phone2, header: client.phone2Identity)
        phone3Field.setContent(client.phone3, header: client.phone3Identity)

        email1Field.setContent(client.email, header: client.emailIdentity)
        email2Field.setContent(client.email2, header: client.email2Identity)
    }
}
