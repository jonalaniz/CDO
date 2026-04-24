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
        window.subtitle = "\(tableView.numberOfRows) clients"
    }

    private func setupTableView() {
        tableView.style = .inset
        tableView.headerView = nil
        tableView.rowSizeStyle = .custom
        tableView.floatsGroupRows = false

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
