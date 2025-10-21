//
//  ClientManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/19/25.
//

import AppKit

protocol DataManagerDelegate: AnyObject {
    func didUpdateClients()
}

final class ClientManager: NSObject {
    static let shared = ClientManager()
    private let service = CDOService.shared
    var clients = [ClientSummary]()
    weak var delegate: DataManagerDelegate?
    private var sortedByColumn: Column?

    private override init() {}

    func fetchClients() {
        Task {
            do {
                clients = try await service.fetchClients()
                    .sorted { $0.id < $1.id }
                updateDelegate()
            } catch {
                print(error)
            }
        }
    }

    @MainActor
    private func updateDelegate() {
        delegate?.didUpdateClients()
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
        return clients.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard
            let tableColumn = tableColumn,
            let column = Column(rawValue: tableColumn.identifier.rawValue)
        else { return nil }

        let client = clients[row]

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

    private func sortBy(_ column: Column) {
        guard column != sortedByColumn else {
            clients.reverse()
            return
        }

        sortedByColumn = column

        switch column {
        case .firstName: clients.sort {
            ($0.firstName == $1.firstName) ? $0.lastName < $1.lastName : $0.firstName < $1.firstName
        }
        case .lastName: clients.sort {
            ($0.lastName == $1.lastName) ? $0.firstName < $1.firstName : $0.lastName < $1.lastName
        }
        case .address1: return
        case .address2: return
        case .city: clients.sort {
            ($0.city == $1.city) ? $0.lastName < $1.lastName : $0.city < $0.city
        }
        case .state: clients.sort {
            ($0.state < $1.state) ? $0.lastName < $1.lastName : $0.state < $1.state
        }
        case .zip: return
        }

        updateDelegate()
    }
}
