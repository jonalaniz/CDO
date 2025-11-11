//
//  ReminderService.swift
//  CDO
//
//  Created by Jon Alaniz on 11/9/25.
//

import Foundation

final class ReminderService: CRUDService {
    static let shared = ReminderService()
    typealias Model = Reminder

    private let apiManager = APIManager.shared
    private let baseURLString = "http://127.0.0.1:8080"

    private init() {}

    func fetchAll() async throws -> [Model] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.reminders.path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func fetch(id: CustomStringConvertible) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.reminder(id).path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func create(_ item: Codable) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.reminders.path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }

        return try await apiManager.createResource(urlWithEndpoint, body: data)
    }

    func update(id: CustomStringConvertible, with item: Codable) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.reminder(id).path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }
        return try await apiManager.updateResource(urlWithEndpoint, body: data)
    }

    func delete(id: Int) async throws {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.reminder(id).path)!
        try await apiManager.deleteResource(urlWithEndpoint)
    }

    // MARK: - Reminder Specific Requests
    func fetchWithClients() async throws -> [Reminder] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.reminders.path)!
        var components = URLComponents(url: urlWithEndpoint, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "includeClients", value: "true")]
        guard let url = components?.url else { throw APIManagerError.invalidURL }
        return try await apiManager.fetchResource(url)
    }
}
