//
//  ClientsTableViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 4/22/26.
//

import Cocoa

final class ClientsTableViewController: NSViewController {
    let tableView = NSTableView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        setTitle()
    }

    // MARK: - Setup

    private func setupTableView() {
        tableView.style = .inset
        tableView.headerView = nil
        tableView.addTableColumn(.emptyColumn)

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

    private func setTitle() {
        guard let window = view.window else { return }

        let subtitle = switch tableView.numberOfRows {
        case 0: "No clients"
        case 1: "One client"
        default: "\(tableView.numberOfRows) clients"
        }

        window.subtitle = subtitle
    }
}
