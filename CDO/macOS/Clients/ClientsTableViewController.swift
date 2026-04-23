//
//  ClientsTableViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 4/22/26.
//

import Cocoa

final class ClientsTableViewController: NSViewController {
    let tableView = NSTableView()

    override func viewDidLoad() {
        setupTableView()
    }

    override func viewDidAppear() {
        setTitle()
    }

    private func setTitle() {
        guard let window = view.window else { return }
        window.subtitle = "\(numberOfRows(in: tableView)) clients"
    }

    private func setupTableView() {
        tableView.style = .inset
        tableView.headerView = nil
        tableView.rowSizeStyle = .custom
        tableView.floatsGroupRows = false

        tableView.dataSource = self
        tableView.delegate = self

        let scrollView = NSScrollView(frame: .zero)
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false
        scrollView.documentView = tableView

        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Column"))
        tableView.addTableColumn(column)

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ClientsTableViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 100
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let nameHeight = NSFont.preferredFont(forTextStyle: .headline).boundingRectForFont.height
        let addressHeight = NSFont.preferredFont(forTextStyle: .body).boundingRectForFont.height
        return nameHeight + (addressHeight * 3) + 20
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: ClientCell.identifier, owner: self)
        as? ClientCell ?? ClientCell()

        cell.setLabels(
            name: "Jon Alaniz",
            address: """
            4400 Piss Drive
            Apt 420
            San Antonio, TX 78229
            """
        )
        return cell
    }
}
