//
//  EmployerManager.swift
//  CDO
//
//  Created by Jon Alaniz on 11/10/25.
//

import AppKit

final class EmployerManager: BaseDataManager {
    // MARK: - Shared Instance
    static let shared = EmployerManager()
    private override init() {}

    // MARK: - Properties
    private let service = EmployerService.shared
    private var employers = [EmployerSummary]()

    // MARK: - Public API
    func initialize() async {
        fetchEmployers()
    }

    func fetchEmployers() {
        Task {
            do {
                employers = try await service.fetchAll()
                updateDelegate()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - NSTableViewDelegate & NSTableViewDataSource

extension EmployerManager: NSTableViewDelegate, NSTableViewDataSource {

}
