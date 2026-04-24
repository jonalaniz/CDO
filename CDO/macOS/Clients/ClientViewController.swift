//
//  ClientViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 4/22/26.
//

import Cocoa

final class ClientViewController: NSViewController {
    let collectionView = NSCollectionView()
    var client: ClientDetail?

    override func viewDidLoad() {
        setupUI()
        constrainUI()
    }

    override func viewDidLayout() {
        super.viewDidLayout()
        updateItemSize()
    }

    private func updateItemSize() {
        guard let layout = collectionView.collectionViewLayout as? NSCollectionViewFlowLayout else { return }

        let insets = layout.sectionInset.left + layout.sectionInset.right
        let spacing = layout.minimumInteritemSpacing
        let availableWidth = collectionView.bounds.width - insets
        let minWidth: CGFloat = 250
        let maxWidth: CGFloat = 300

        // How many columns fit at minimum width
        let columns = floor((availableWidth + spacing) / (minWidth + spacing))
        // Divide available space equally among columns
        let itemWidth = (availableWidth - (columns - 1) * spacing) / columns
        // Clamp to max
        let clampedWidth = min(itemWidth, maxWidth)

        layout.itemSize = NSSize(width: clampedWidth, height: 400)
    }

    private func setupUI() {
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSSize(width: 280, height: 400)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = NSEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func constrainUI() {
        let scrollView = NSScrollView(frame: .zero)
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false
        scrollView.documentView = collectionView
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        collectionView.isHidden = true
    }

    func setClient(_ client: ClientDetail) {
        self.client = client

        collectionView.isHidden = false
        collectionView.reloadData()
    }

    func clearClient() {
        client = nil
        collectionView.isHidden = true
        // Do setup here
    }
}

extension ClientViewController: NSCollectionViewDataSource, NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return ClientCard.allCases.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let card = ClientCard(rawValue: indexPath.item) else { return NSCollectionViewItem() }
        let cell = ClientCollectionViewItem()
        cell.titleLabel.stringValue = card.title
        return cell
    }
}

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
        case .employmentProfile: "Employemnt Profile"
        case .placements: "Placements"
        case .checklist: "Checklist"
        }
    }
}

class ClientCollectionViewItem: NSCollectionViewItem {
    static let identifier = NSUserInterfaceItemIdentifier("ClientCollectionCell")

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
        titleLabel.font = NSFont.preferredFont(forTextStyle: .title1)
//        button.wantsLayer = true
//        button.layer?.cornerRadius = height / 2
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

final class PersonalInformationCollectionViewItem: ClientCollectionViewItem {

}
