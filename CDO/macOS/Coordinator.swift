//
//  Coordinator.swift
//  CDO
//
//  Created by Jon Alaniz on 10/20/25.
//

import Foundation

final class CDOCoordinator: NSObject {
    // MARK: - Shared Instance

    static let shared = CDOCoordinator()

    // MARK: - Properties
    private let clientManager = ClientManager.shared
    private let remindersManager = RemindersManager.shared

    private override init() {}

}

extension CDOCoordinator: SidebarDelegate {
    func selectionMade(_ source: SourceItem) {
        print(source)
    }
}
