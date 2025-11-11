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
    private let service = ClientService.shared
    private var clients = [Client]()
    private var summaries = [ClientSummary]()
    private var selectedColumn: Column?

    // MARK: - Public API
    func initialize() async {
        guard
            let cachedSummaries: [ClientSummary] = load(.clientSummaries),
            let cachedClients: [Client] = load(.clients)
        else {
            fetchClientSummaries()
            fetchAllClientData()
            return
        }

        summaries = cachedSummaries
        clients = cachedClients
    }

    func fetchAllClientData() {
        Task {
            do {
                clients = try await service.fetchAll()
                save(clients, key: .clients)
            } catch {
                print(error)
            }
        }
    }

    func fetchClientSummaries() {
        Task {
            do {
                summaries = try await service.fetchSummaries()
                    .sorted { $0.id < $1.id }
                save(summaries, key: .clientSummaries)
                updateDelegate()
            } catch {
                print(error)
            }
        }
    }

    func fetchClient(id: Int) {
        Task {
            do {
                let client = try await service.fetch(id: id)
                updatedItem(client)
            }
        }
    }

    override func cachedItem(for id: Int) -> Any? {
        return clients.first(where: { $0.id == id })
    }

    func cachedItem(at index: Int) -> Any? {
        return clients[index]
    }

    func clientMenuArray() -> [ClientMenuItem] {
        let clientArray = summaries.map { $0.asClientMenuItem() }
        return clientArray.sorted { $0.name < $1.name }
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
        return summaries.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard
            let tableColumn = tableColumn,
            let column = Column(rawValue: tableColumn.identifier.rawValue)
        else { return nil }

        let client = summaries[row]

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
        guard column != selectedColumn else {
            summaries.reverse()
            return
        }

        selectedColumn = column

        switch column {
        case .firstName: summaries.sort {
            ($0.firstName == $1.firstName) ? $0.lastName < $1.lastName : $0.firstName < $1.firstName
        }
        case .lastName: summaries.sort {
            ($0.lastName == $1.lastName) ? $0.firstName < $1.firstName : $0.lastName < $1.lastName
        }
        case .address1: return
        case .address2: return
        case .city: summaries.sort {
            ($0.city == $1.city) ? $0.lastName < $1.lastName : $0.city < $0.city
        }
        case .state: summaries.sort {
            ($0.state < $1.state) ? $0.lastName < $1.lastName : $0.state < $1.state
        }
        case .zip: return
        }

        updateDelegate()
    }
}
