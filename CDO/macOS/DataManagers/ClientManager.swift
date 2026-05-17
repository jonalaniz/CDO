//
//  ClientManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import AppKit

final class ClientManager: NSObject {
    weak var delegate: (any ClientManagerDelegate)?
    private let service: ClientService
    private var clients = [ClientSummary]()

    init(service: ClientService) {
        self.service = service
        super.init()
        fetchClientSummaries()
    }

    // MARK: - Public API
    func fetchClientSummaries() {
        Task {
            do {
                clients = try await service.fetchAll()
                    .sorted { $0.name < $1.name }
                delegate?.summariesDidChange()
            } catch {
                print(error)
            }
        }
    }

    func fetchClient(id: Int) {
        Task {
            do {
                let client = try await service.fetch(id: id)
                delegate?.detailDidChange(client)
            } catch {
                print(error)
            }
        }
    }
}

extension ClientManager: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return clients.count
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let nameHeight = NSFont.heightFor(preferredFont: .headline)
        let addressHeight = NSFont.heightFor(preferredFont: .body)
        return nameHeight + (addressHeight * 2) + 20
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(
            withIdentifier: ClientCell.identifier,
            owner: self
        ) as? ClientCell ?? ClientCell()

        let client =  clients[row]
        cell.configure(with: client)

        return cell
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        guard
            let tableView = notification.object as? NSTableView,
            tableView.selectedRow != -1
        else { return }

        let client = clients[tableView.selectedRow]
        fetchClient(id: client.id)
    }
}
