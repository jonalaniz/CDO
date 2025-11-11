//
//  CacheManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/29/25.
//

import Foundation

class StatesManager: BaseDataManager {
    // MARK: - Shared Instance
    static let shared = StatesManager()
    private override init() {}

    // MARK: - Properties
    private let service = StatesService.shared
    private var states = [State]()

    func initialize() async {
        guard let cached: [State] = load(.states)
        else {
            fetchStates()
            return
        }

        states = cached
    }

    func fetchStates() {
        Task {
            do {
                let fetchedStates = try await service.fetchAll()
                guard fetchedStates != states else { return }
                states = fetchedStates
                save(states, key: .states)
            } catch {
                print(error.description)
            }
        }
    }
}
