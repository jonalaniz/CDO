//
//  CDOService.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

protocol CRUDService {
    associatedtype Model: Codable
    func fetchAll() async throws -> [Model]
    func fetch(id: CustomStringConvertible) async throws -> Model
    func create(_ item: Codable) async throws -> Model
    func update(id: CustomStringConvertible, with item: Codable) async throws -> Model
    func delete(id: Int) async throws
}

final class StatesService: CRUDService {
    static let shared = StatesService()
    typealias Model = State

    private let apiManager = APIManager.shared
    private let baseURLString = "http://127.0.0.1:8080"

    private init() {}

    func fetchAll() async throws -> [Model] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.states.path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func fetch(id: CustomStringConvertible) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.state(id).path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func create(_ item: Codable) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.states.path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }

        return try await apiManager.createResource(urlWithEndpoint, body: data)
    }

    func update(id: CustomStringConvertible, with item: Codable) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.state(id).path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }
        return try await apiManager.updateResource(urlWithEndpoint, body: data)
    }

    func delete(id: Int) async throws {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.state(id).path)!
        try await apiManager.deleteResource(urlWithEndpoint)
    }
}

final class CDOService {
    static let shared = CDOService()

    private let apiManager = APIManager.shared
    private let baseURLString = "http://127.0.0.1:8080"

    private init() {}

    func fetchClients() async throws -> [Client] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.clients.path)!
        return try await apiManager.fetchResource(urlWithEndpoint)

    }

    func fetchClientSummaries() async throws -> [ClientSummary] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.clientSummaries.path)!
        return try await apiManager.fetchResource(urlWithEndpoint)

    }

    func fetchClient(id: CustomStringConvertible) async throws -> Client {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.client(id).path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func fetchCounselors() async throws -> [Counselor] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.counselors.path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func fetchEmployers() async throws -> [Employer] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.employers.path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func fetchPOs() async throws -> [PO] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.pos.path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func fetchReminder(with id: Int) async throws -> Reminder {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.reminder(id).path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func fetchReminders(withClients: Bool = false) async throws -> [Reminder] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.reminders.path)!

        var components = URLComponents(url: urlWithEndpoint, resolvingAgainstBaseURL: true)
        if withClients { components?.queryItems = [URLQueryItem(name: "includeClients", value: "true")] }
        guard let url = components?.url else { throw APIManagerError.invalidURL }

        return try await apiManager.fetchResource(url)
    }
}
