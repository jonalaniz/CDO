//
//  CacheManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/29/25.
//

import Foundation

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

    private init() {
        print("CacheManager Initialized")
        clientManager.fetchAllClients()
        clientManager.fetchClients()
        remindersManager.fetchReminders()
    }
}
