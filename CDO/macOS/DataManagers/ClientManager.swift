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

    private override init() {}

    func fetchClients() {
        Task {
            do {
                clients = try await service.fetchClients()
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
    private enum TableCell: String, CaseIterable {
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
            let column = TableCell(rawValue: tableColumn.identifier.rawValue)
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
}
