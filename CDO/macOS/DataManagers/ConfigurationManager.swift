//
//  ConfigurationManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

struct Configuration: Codable {
    let server: Server
}

struct Server: Codable {
    let url: String
    let secret: String
}

final class ConfigurationManager {
    static let shared = ConfigurationManager()

    weak var delegate: ConfigurationManagerDelegate?

    static private let service = "tech.alaniz.mac.cdo"
    private let keychain = KeychainHelper(service: service)
    var isConfigured: Bool { configuration != nil }

    // TODO: Move get/set to a computed variable
    // NEVER store key in memory
    var configuration: Configuration? {
        get { load() }
        set {
            guard let config = newValue else { return }
            save(config)
        }
    }

    private init() {}

    private func load() -> Configuration? {
        guard
            let config = try? keychain.get(Configuration.self, for: "Configuration")
        else { return nil }
        return config
    }

    func save(_ configuration: Configuration) {
        try? keychain.set(configuration, for: "Configuration")
        delegate?.configurationDidChange()
    }

    func clear() {
        try? keychain.delete(account: "Configuration")
    }
}

protocol ConfigurationManagerDelegate: AnyObject {
    func configurationDidChange()
}
