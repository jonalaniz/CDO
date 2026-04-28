//
//  NotesViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 4/25/26.
//

import Cocoa

final class NotesViewController: NSViewController {
    private let tableView = NSTableView()
    private var scrollView = NSScrollView.verticalScroller()
    private var clientNotes = [ClientNote]()

    override func viewDidLoad() {
        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.style = .automatic
        tableView.usesAutomaticRowHeights = true
        tableView.backgroundColor = .clear
        tableView.headerView = nil
        tableView.floatsGroupRows = false
        tableView.addTableColumn(NSTableColumn())

        scrollView.documentView = tableView
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setNotes(_ clientNotes: [ClientNote]) {
        self.clientNotes = clientNotes
        tableView.reloadData()
        scrollView.documentView?.scroll(.zero)
    }
}

extension NotesViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return clientNotes.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(
            withIdentifier: NoteCell.identifier,
            owner: self
        ) as? NoteCell ?? NoteCell()

        let note = clientNotes[row]
        cell.configureNote(note)
        return cell
    }
}
