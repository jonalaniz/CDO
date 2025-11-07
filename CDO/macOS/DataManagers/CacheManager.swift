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

    // MARK: - Properties
    private var states = [State]()

    func initialize() async {
        guard let cached: [State] = CacheManager.shared.load(forKey: .states)
        else { return }
        print(cached)
        states = cached
    }

    private func save() {
        CacheManager.shared.save(states, forKey: .states)
    }

    func fetchStates() {
        Task {
            do {
                let fetchedStates = try await service.fetchStates()
                guard fetchedStates != states else { return }
                states = fetchedStates
                print(states)
                save()
            } catch {
                print(error.description)
            }
        }
    }
}
