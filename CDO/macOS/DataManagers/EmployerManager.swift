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
    private var employers = [Employer]()

    // MARK: - Public API
    func initialize() async {
        guard let cachedEmployers: [Employer] = load(.employers)
        else {
            fetchEmployers()
            return
        }

        employers = cachedEmployers
    }

    func fetchEmployers() {
        Task {
            do {
                employers = try await service.fetchAll()
                save(employers, key: .employers)
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
