//
//  ClientViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 4/22/26.
//

import Cocoa

final class ClientViewController: NSViewController {
    let collectionView = NSCollectionView()

    override func viewDidLoad() {
        setupCollectionView()
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

    private func setupCollectionView() {
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSSize(width: 280, height: 400)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = NSEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        collectionView.collectionViewLayout = layout

        collectionView.dataSource = self
        collectionView.delegate = self

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
    }
}

extension ClientViewController: NSCollectionViewDataSource, NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {

        // let cell = collectionView.makeItem(withIdentifier: ClientBaseCollectionViewItem.identifier, for: indexPath)
//                as? ClientBaseCollectionViewItem ?? ClientBaseCollectionViewItem()

        let cell = ClientBaseCollectionViewItem()
        return cell
    }
}

final class ClientBaseCollectionViewItem: NSCollectionViewItem {
    static let identifier = NSUserInterfaceItemIdentifier("ClientCollectionCell")
    let glassView = NSGlassEffectView()

    override func loadView() {
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

    override func viewDidLoad() {

    }
}
