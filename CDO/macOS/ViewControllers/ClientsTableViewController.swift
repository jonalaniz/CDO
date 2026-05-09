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
        super.viewDidLoad()
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
        tableView.addTableColumn(
            NSTableColumn()
        )

        let scrollView = NSScrollView.verticalScroller()
        scrollView.documentView = tableView

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
