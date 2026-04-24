//
//  CacheManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/29/25.
//

import Foundation

class StatesManager {
    // MARK: - Shared Instance
    static let shared = StatesManager()

    // MARK: - Properties
    private let service = StatesService.shared
    private var states = [State]()

    func initialize() async {
        fetchStates()
    }

    func fetchStates() {
        Task {
            do {
                let fetchedStates = try await service.fetchAll()
                guard fetchedStates != states else { return }
                states = fetchedStates
            } catch {
                print(error.description)
            }
        }
    }
}
