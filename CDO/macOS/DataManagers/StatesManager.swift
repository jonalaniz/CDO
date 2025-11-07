//
//  StatesManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/31/25.
//

import Foundation

enum CacheKey: String {
    case states = "States"
}

class CacheManager {
    // Potentially have either the cache manager
    // or the associated dataManager hold specific
    // clients/reminders/etc.

    // Fetch should fetch the basic data that is needed, not
    // specific objects.
    static let shared = CacheManager()

    // MARK: Dependencies
    private let clientManager = ClientManager.shared
    private let remindersManager = RemindersManager.shared
    private let statesManager = StatesManager.shared

    private let defaults = UserDefaults.standard

    private init() {}

    func initialize() {
        Task {
            await statesManager.initialize()
            clientManager.fetchAllClientData()
            clientManager.fetchClientSummaries()
            remindersManager.fetchReminders()
            // TODO: This is where we will tell the coordinator everything is updates
            // In the future we will then show the interface after
            // the loading screen is done.
        }
    }

    func loadObject(key: CacheKey) -> Data? {
        return defaults.object(forKey: key.rawValue) as? Data
    }

    func load<T: Codable>(forKey key: CacheKey) -> T? {
        guard let data = defaults.data(forKey: key.rawValue)
        else { return nil }

        return try? JSONDecoder().decode(T.self, from: data)
    }

    func save<T: Codable>(_ value: T, forKey key: CacheKey) {
        do {
            let data = try JSONEncoder().encode(value)
            defaults.set(data, forKey: key.rawValue)
        } catch {
            print(error.description)
        }
    }
}
