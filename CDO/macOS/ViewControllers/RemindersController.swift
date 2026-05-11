//
//  RemindersController.swift
//  CDO
//
//  Created by Jon Alaniz on 5/8/26.
//

import Cocoa

class RemindersController: NSViewController {
    lazy var segmentedControl = NSSegmentedControl(
        labels: [],
        trackingMode: .selectOne,
        target: self,
        action: #selector(tabClicked)
    )

    let tableView = NSTableView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Setup

    private func setupTableView() {
        tableView.style = .plain
        tableView.headerView = RemindersHeaderView()
        tableView.usesAutomaticRowHeights = true
        tableView.backgroundColor = .clear
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

    @objc func tabClicked(_ sender: NSSegmentedControl) {
        print(sender.selectedSegment)
    }
}

extension NSTableView {

}
