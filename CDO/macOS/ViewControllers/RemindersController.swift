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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        tableView.style = .plain
        tableView.backgroundColor = .clear
        tableView.headerView = RemindersHeaderView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowSizeStyle = .custom
        tableView.floatsGroupRows = false
        let column = NSTableColumn()
        column.title = ""
        tableView.addTableColumn(column)

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

final class RemindersHeaderView: NSTableHeaderView {
    let headerLabel = NSTextField(labelWithString: "Reminders")

    init() {
        let height = NSFont.preferredFont(
            forTextStyle: .headline
        ).boundingRectForFont.size.height
        super.init(frame: .init(x: 0, y: 0, width: 0, height: height * 2))
        setupUI()
    }

    private func setupUI() {
        layer?.backgroundColor = .clear
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = NSFont.preferredFont(forTextStyle: .headline)
        headerLabel.alignment = .center
        addSubview(headerLabel)

        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
