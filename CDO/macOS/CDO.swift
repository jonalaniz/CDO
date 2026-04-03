//
//  CDO.swift
//  CDO
//
//  Created by Jon Alaniz on 4/2/26.
//
//  Analagous to AppServices.cs in CDO.Win

import Foundation

final class CDO {
    static let shared = CDO()

    private let clientService = ClientService.shared
    private let reminderService = ReminderService.shared

    private let configurationManager = ConfigurationManager.shared

    var isConfigured: Bool { return configurationManager.configuration != nil }

    private init() {
        guard let secret = configurationManager.configuration?.server.url
        else { return }
        configureNetworking(with: secret)
        print(secret)
    }

    private func configureNetworking(with secret: String) {
        clientService.updateBaseAddress(secret)
        reminderService.updateBaseAddress(secret)
    }

}
