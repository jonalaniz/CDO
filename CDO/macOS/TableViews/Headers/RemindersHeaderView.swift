//
//  RemindersHeaderView.swift
//  CDO
//
//  Created by Jon Alaniz on 5/8/26.
//

import Cocoa

final class RemindersHeaderView: NSTableHeaderView {
    let headerLabel = NSTextField(labelWithString: "Reminders")

    init() {
        let height = NSFont.heightFor(preferredFont: .headline)
        super.init(frame: .init(x: 0, y: 0, width: 0, height: height * 2))
        setupUI()
    }

    private func setupUI() {
        layer?.backgroundColor = .clear
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = NSFont.preferredFont(forTextStyle: .headline)
        headerLabel.alignment = .center
        addSubview(headerLabel)

        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
