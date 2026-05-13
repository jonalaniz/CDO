//
//  ClientViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 4/22/26.
//

import Cocoa

final class ClientViewController: NSViewController {
    private var client: ClientDetail?
    let collectionView = NSCollectionView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    override func viewDidLayout() {
        super.viewDidLayout()
        updateItemSize()
    }

    // MARK: - Setup

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSSize(width: 280, height: 400)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = NSEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.collectionViewLayout = layout

        let scrollView = NSScrollView.verticalScroller()
        scrollView.documentView = collectionView

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        collectionView.isHidden = true
    }

    private func updateItemSize() {
        guard let layout = collectionView.collectionViewLayout as? NSCollectionViewFlowLayout else { return }

        let insets = layout.sectionInset.left + layout.sectionInset.right
        let spacing = layout.minimumInteritemSpacing
        let availableWidth = collectionView.bounds.width - insets
        let minWidth: CGFloat = 250
        let maxWidth: CGFloat = 320

        // How many columns fit at minimum width
        let columns = floor((availableWidth + spacing) / (minWidth + spacing))
        // Divide available space equally among columns
        let itemWidth = (availableWidth - (columns - 1) * spacing) / columns
        // Clamp to max
        let clampedWidth = min(itemWidth, maxWidth)

        layout.itemSize = NSSize(width: clampedWidth, height: 330)
    }

    // MARK: - Public API

    func setClient(_ client: ClientDetail) {
        self.client = client

        collectionView.isHidden = false
        collectionView.reloadData()
    }

    func clearClient() {
        client = nil
        collectionView.isHidden = true
    }
}

extension ClientViewController: NSCollectionViewDataSource, NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return ClientCard.allCases.count
    }

    func collectionView(
        _ collectionView: NSCollectionView,
        itemForRepresentedObjectAt indexPath: IndexPath)
    -> NSCollectionViewItem {
        guard
            let card = ClientCard(rawValue: indexPath.item),
            let unwrappedClient = client
        else { return NSCollectionViewItem() }

        switch card {
        case .personal:
            let cell = PersonalInformationCollectionViewItem()
            cell.titleLabel.stringValue = card.title
            cell.configure(with: unwrappedClient)
            return cell
        default:
            let cell = ClientCardItem()
            cell.titleLabel.stringValue = card.title
            return cell
        }

    }
}
