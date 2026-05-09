//
//  ReminderService.swift
//  CDO
//
//  Created by Jon Alaniz on 11/9/25.
//

import Foundation

final class ReminderService: CRUDService {
    typealias Model = Reminder
    typealias Detail = Reminder

    private let apiManager = APIManager.shared
    private var baseURLString: String

    private init(baseURL: String) {
        baseURLString = baseURL
    }

    func fetchAll() async throws -> [Model] {
        let fullAddress = URL(string: baseURLString + Endpoint.reminders.path)!
        var components = URLComponents(url: fullAddress, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "includeClients", value: "true")]
        guard let url = components?.url else { throw APIManagerError.invalidURL }
        return try await apiManager.fetchResource(url)
    }

    func fetch(id: Int) async throws -> Detail {
        let fullAddress = URL(string: baseURLString + Endpoint.reminder(id).path)!
        return try await apiManager.fetchResource(fullAddress)
    }

    func create(_ item: Codable) async throws -> Detail {
        let fullAddress = URL(string: baseURLString + Endpoint.reminders.path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }

        return try await apiManager.createResource(fullAddress, body: data)
    }

    func update(id: Int, with item: Codable) async throws {
        let fullAddress = URL(string: baseURLString + Endpoint.reminder(id).path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }
        try await apiManager.updateResource(fullAddress, body: data)
    }

    func delete(id: Int) async throws {
        let fullAddress = URL(string: baseURLString + Endpoint.reminder(id).path)!
        try await apiManager.deleteResource(fullAddress)
    }

    // MARK: - Convenience Methods
    func updateBaseAddress(_ string: String) {
        baseURLString = string
    }
}
