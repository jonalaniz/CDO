//
//  StatesManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/31/25.
//

import Foundation

enum CacheKey: String {
    case clients = "Clients"
    case clientSummaries = "ClientSummaries"
    case employers = "Employers"
    case reminders = "Reminders"
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
    private let employerManager = EmployerManager.shared
    private let remindersManager = RemindersManager.shared
    private let statesManager = StatesManager.shared

    private let defaults = UserDefaults.standard

    private init() {}

    func initialize() {
        Task {
            await statesManager.initialize()
            await clientManager.initialize()
            await employerManager.initialize()
            await remindersManager.initialize()
            print(clientManager.clientMenuArray())
            // Notify coordinator we have initialized
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
