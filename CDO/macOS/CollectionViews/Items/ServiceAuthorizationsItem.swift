//
//  ServiceAuthorizationsItem.swift
//  CDO
//
//  Created by Jon Alaniz on 5/15/26.
//

import Cocoa

final class ServiceAuthorizationsItem: ClientCardItem {
    private let tableView = NSTableView()
    private var serviceAuthorizations = [SADetail]()

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
        serviceAuthorizations = client.sas
        tableView.reloadData()
    }
}

extension ServiceAuthorizationsItem: NSTableViewDataSource, NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return ClientSACell.height
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return serviceAuthorizations.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(
            withIdentifier: ClientSACell.identifier,
            owner: self
        ) as? ClientSACell ?? ClientSACell()

        let item = serviceAuthorizations[row]
        cell.configure(with: item)
        return cell
    }
}
