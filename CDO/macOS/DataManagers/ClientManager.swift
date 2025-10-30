//
//  ClientManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import AppKit

final class ClientManager: BaseDataManager {
    // MARK: - Shared Instance
    static let shared = ClientManager()
    private override init() {}

    // MARK: - Properties
    private var clients = [Client]()
    var clientSummaries = [ClientSummary]()
    private var sortedByColumn: Column?

    // MARK: - Public API
    func fetchAllClients() {
        Task {
            do {
                clients = try await service.fetchAllClients()
            } catch {
                print(error)
            }
        }
    }

    func fetchClients() {
        Task {
            do {
                clientSummaries = try await service.fetchClientSummaries()
                    .sorted { $0.id < $1.id }
                updateDelegate()
            } catch {
                print(error)
            }
        }
    }

    func fetchClient(id: Int) {
        Task {
            do {
                let client = try await service.fetchClient(id: id)
                updatedItem(client)
            }
        }
    }

    @MainActor
    private func updateDelegate() {
        delegate?.didUpdateItems()
    }

    @MainActor
    private func updatedItem(_ client: Client) {
        delegate?.didUpdateItem(client)
    }

    override func cachedItem(for id: Int) -> Any? {
        return clients.first(where: { $0.id == id })
    }
}

extension ClientManager: NSTableViewDelegate, NSTableViewDataSource {
    private enum Column: String, CaseIterable {
        case firstName = "FirstNameID"
        case lastName = "LastNameID"
        case address1 = "Address1ID"
        case address2 = "Address2ID"
        case city = "CityID"
        case state = "StateID"
        case zip = "ZipID"

        var identifier: NSUserInterfaceItemIdentifier {
            .init(rawValue)
        }
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return clientSummaries.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard
            let tableColumn = tableColumn,
            let column = Column(rawValue: tableColumn.identifier.rawValue)
        else { return nil }

        let client = clientSummaries[row]

        guard let cell = tableView.makeView(
            withIdentifier: column.identifier, owner: self
        ) as? NSTableCellView else {
            print("Cannot cast CellView")
            return nil
        }

        switch column {
        case .firstName: cell.textField?.stringValue = client.firstName
        case .lastName: cell.textField?.stringValue = client.lastName
        case .address1: cell.textField?.stringValue = client.address1 ?? ""
        case .address2: cell.textField?.stringValue = client.address2 ?? ""
        case .city: cell.textField?.stringValue = client.city
        case .state: cell.textField?.stringValue = client.state
        case .zip: cell.textField?.stringValue = client.zip ?? ""
        }

        return cell
    }

    func tableView(_ tableView: NSTableView, mouseDownInHeaderOf tableColumn: NSTableColumn) {
        guard let column = Column(rawValue: tableColumn.identifier.rawValue)
        else { return }
        sortBy(column)
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        delegate?.didSelect()
    }

    private func sortBy(_ column: Column) {
        guard column != sortedByColumn else {
            clientSummaries.reverse()
            return
        }

        sortedByColumn = column

        switch column {
        case .firstName: clientSummaries.sort {
            ($0.firstName == $1.firstName) ? $0.lastName < $1.lastName : $0.firstName < $1.firstName
        }
        case .lastName: clientSummaries.sort {
            ($0.lastName == $1.lastName) ? $0.firstName < $1.firstName : $0.lastName < $1.lastName
        }
        case .address1: return
        case .address2: return
        case .city: clientSummaries.sort {
            ($0.city == $1.city) ? $0.lastName < $1.lastName : $0.city < $0.city
        }
        case .state: clientSummaries.sort {
            ($0.state < $1.state) ? $0.lastName < $1.lastName : $0.state < $1.state
        }
        case .zip: return
        }

        updateDelegate()
    }
}
