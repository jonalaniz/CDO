//
//  LablePair.swift
//  CDO
//
//  Created by Jon Alaniz on 5/12/26.
//

import Cocoa

final class LabelPairView: NSView {
    private let headerField = NSTextField(labelWithString: "")
    private let contentField = NSTextField(labelWithString: "")

    convenience init(header: String) {
        self.init(frame: .zero)
        headerField.stringValue = header
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        headerField.font = .preferredFont(forTextStyle: .headline)
        contentField.maximumNumberOfLines = 0
        contentField.lineBreakMode = .byWordWrapping

        headerField.translatesAutoresizingMaskIntoConstraints = false
        contentField.translatesAutoresizingMaskIntoConstraints = false
        contentField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        addSubview(headerField)
        addSubview(contentField)

        NSLayoutConstraint.activate([
            headerField.topAnchor.constraint(equalTo: topAnchor),
            headerField.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerField.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentField.topAnchor.constraint(equalTo: headerField.bottomAnchor, constant: 4),
            contentField.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentField.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func setContent(_ content: String?) {
        contentField.stringValue = content ?? ""

        headerField.textColor = contentField.stringValue == ""
        ? .secondaryLabelColor : .labelColor
    }
}

final class LabelTextViewPair: NSView {
    private let headerField = NSTextField(labelWithString: "")
    private let contentField = NSTextView(frame: .zero)

    convenience init(header: String) {
        self.init(frame: .zero)
        headerField.stringValue = header
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        headerField.font = .preferredFont(forTextStyle: .headline)
//        contentField.maximumNumberOfLines = 0
//        contentField.lineBreakMode = .byWordWrapping

        headerField.translatesAutoresizingMaskIntoConstraints = false
        contentField.translatesAutoresizingMaskIntoConstraints = false
        contentField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        addSubview(headerField)
        addSubview(contentField)

        NSLayoutConstraint.activate([
            headerField.topAnchor.constraint(equalTo: topAnchor),
            headerField.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerField.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentField.topAnchor.constraint(equalTo: headerField.bottomAnchor, constant: 4),
            contentField.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentField.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func setContent(_ content: String?) {
        contentField.string = content ?? ""

        headerField.textColor = contentField.string == ""
        ? .secondaryLabelColor : .labelColor
    }
}
