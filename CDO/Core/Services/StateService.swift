//
//  StatesService.swift
//  CDO
//
//  Created by Jon Alaniz on 11/8/25.
//

import Foundation

final class StatesService: CRUDService {
    static let shared = StatesService()
    typealias Model = State

    private let apiManager = APIManager.shared
    private var baseURLString = "http://127.0.0.1:8080"

    private init() {}

    func fetchAll() async throws -> [Model] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.states.path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func fetch(id: Int) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.state(id).path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func create(_ item: Codable) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.states.path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }

        return try await apiManager.createResource(urlWithEndpoint, body: data)
    }

    func update(id: Int, with item: Codable) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.state(id).path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }
        return try await apiManager.updateResource(urlWithEndpoint, body: data)
    }

    func delete(id: Int) async throws {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.state(id).path)!
        try await apiManager.deleteResource(urlWithEndpoint)
    }

    // MARK: - Convenience Methods
    func updateBaseAddress(_ string: String) {
        baseURLString = string
    }
}
