//
//  PlacementItem.swift
//  CDO
//
//  Created by Jon Alaniz on 5/17/26.
//

import Cocoa

final class PlacementItem: ClientCardItem {
    private let tableView = NSTableView()
    private var placements = [PlacementDetail]()

    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.style = .plain
        tableView.headerView = nil
        tableView.backgroundColor = .clear
        tableView.addTableColumn(.emptyColumn)

        let scrollView = NSScrollView.verticalScroller()
        scrollView.documentView = tableView
        outlineView.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: outlineView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: outlineView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: outlineView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: outlineView.trailingAnchor)
        ])
    }

    override func configure(with client: ClientDetail) {
        placements = client.placements
        tableView.reloadData()
    }
}

extension PlacementItem: NSTableViewDataSource, NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return ClientPlacementCell.height
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return placements.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(
            withIdentifier: ClientPlacementCell.identifier,
            owner: self
        ) as? ClientPlacementCell ?? ClientPlacementCell()

        let item = placements[row]
        cell.configure(with: item)
        return cell
    }
}
