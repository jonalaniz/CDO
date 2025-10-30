//
//  CacheManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/29/25.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()

    // MARK: Dependencies
    private let clientManager = ClientManager.shared

    private init() {
        print("CacheManager Initialized")
        clientManager.fetchClients()
    }
}
