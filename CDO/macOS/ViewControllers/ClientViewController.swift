//
//  ClientViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/13/25.
//

import Cocoa

class ClientViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!

    private let manager = ClientManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = manager
        tableView.delegate = manager
        manager.delegate = self
        manager.fetchClients()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ClientViewController: ClientManagerDelegate {
    func didUpdateClients() {
        tableView.reloadData()
    }
}

protocol ClientManagerDelegate: AnyObject {
    func didUpdateClients()
}

final class ClientManager: NSObject {
    static let shared = ClientManager()
    private let service = CDOService.shared
    var clients = [ClientSummary]()
    weak var delegate: ClientManagerDelegate?

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

    fileprivate enum TableCell: String, CaseIterable {
        case firstNameCell = "FirstNameID"
        case lastNameCell = "LastNameID"
        case address1Cell = "Address1ID"
        case address2Cell = "Address2ID"
        case cityCell = "CityID"
        case stateCell = "StateID"
        case zipCell = "ZipID"

        var identifier: NSUserInterfaceItemIdentifier {
            return NSUserInterfaceItemIdentifier(self.rawValue)
        }
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return clients.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard
            let tableColumn = tableColumn,
            let column = TableCell(rawValue: tableColumn.identifier.rawValue)
        else {
            print(tableColumn?.identifier.rawValue)
            print("Cannot cast column as tableColumn")
            return nil
        }

        let client = clients[row]

        guard let cell = tableView.makeView(
            withIdentifier: column.identifier, owner: self
        ) as? NSTableCellView else {
            print("Cannot cast CellView")
            return nil
        }

        switch column {
        case .firstNameCell: cell.textField?.stringValue = client.firstName
        case .lastNameCell: cell.textField?.stringValue = client.lastName
        case .address1Cell: cell.textField?.stringValue = client.address1 ?? ""
        case .address2Cell: cell.textField?.stringValue = client.address2 ?? ""
        case .cityCell: cell.textField?.stringValue = client.city
        case .stateCell: cell.textField?.stringValue = client.state
        case .zipCell: cell.textField?.stringValue = client.zip ?? ""
        }

        return cell
    }
}
