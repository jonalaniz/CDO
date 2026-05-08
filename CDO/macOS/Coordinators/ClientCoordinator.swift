//
//  ClientCoordinator.swift
//  CDO
//
//  Created by Jon Alaniz on 4/23/26.
//

import Cocoa

final class ClientCoordinator: NSObject {
    private let manager: ClientManager
    private let tableViewController: ClientsTableViewController
    private let contentViewController: ClientViewController
    private let notesViewController: NotesViewController
    let toolbarProvider: ToolbarItemProviding

    let rootViewController: ClientSplitViewController

    var minimumWindowWidth: CGFloat {
        return rootViewController.minimumWidth
    }

    init(manager: ClientManager, toolbarProvider: ToolbarItemProviding) {
        self.manager = manager
        self.toolbarProvider = toolbarProvider
        tableViewController = ClientsTableViewController()
        contentViewController = ClientViewController()
        notesViewController = NotesViewController()

        rootViewController = ClientSplitViewController(
            tableView: tableViewController,
            content: contentViewController,
            inspector: notesViewController
        )

        super.init()
        self.manager.delegate = self
    }

    func start() {
        tableViewController.tableView.delegate = manager
        tableViewController.tableView.dataSource = manager
    }

    @objc func newClient() {
        print("Show new client popup view")
    }

    @objc func openDocuments() {
        print("Open Documents")
    }

    @objc func newReminder() {
        print("New Reminder")
    }

    @objc func newNote() {
        print("New Note")
    }

    @objc func saveNote() {
        print("Save Note")

        if true {

        } else {

        }

        guard true else {
            print("False")
            return
        }
    }
}

extension ClientCoordinator: ClientManagerDelegate {
    func summariesDidChange() {
        tableViewController.tableView.reloadData()
    }

    func summaryWasAdded(_ summary: ClientSummary) {
        // insert summary into table view
    }

    func detailDidChange(_ item: ClientDetail?) {
        guard let client = item else {
            // contentController.clearClient()
            return
        }

        contentViewController.setClient(client)
        notesViewController.setNotes(client.clientNotes)
    }

    func itemWasDeleted(id: Int) {
        // To be continued
    }
}
