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

    private var baseURL: String

    private lazy var clientService = ClientService(baseURL: baseURL)
    private let counselorService = CounselorService.shared
    private let employerService = EmployerService.shared
    private let reminderService = ReminderService.shared

    lazy var clientManager = ClientManager(service: clientService)

    private let configurationManager = ConfigurationManager.shared

    var isConfigured: Bool {
        return configurationManager.configuration != nil
    }

    private init() {
        guard let urlString = configurationManager.configuration?.server.url
        else {
            baseURL = ""
            return
        }

        baseURL = urlString
        configureNetworking(with: urlString)
    }

    private func configureNetworking(with secret: String) {
        clientService.updateBaseAddress(secret)
        reminderService.updateBaseAddress(secret)
    }

}
