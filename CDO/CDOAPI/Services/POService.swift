//
//  POService.swift
//  CDO
//
//  Created by Jon Alaniz on 11/9/25.
//

import Foundation

final class POService: CRUDService {
    static let shared = POService()
    typealias Model = PO

    private let apiManager = APIManager.shared
    private let baseURLString = "http://127.0.0.1:8080"

    private init() {}

    func fetchAll() async throws -> [Model] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.pos.path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func fetch(id: CustomStringConvertible) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.po(id).path)!
        return try await apiManager.fetchResource(urlWithEndpoint)
    }

    func create(_ item: Codable) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.pos.path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }

        return try await apiManager.createResource(urlWithEndpoint, body: data)
    }

    func update(id: CustomStringConvertible, with item: Codable) async throws -> Model {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.po(id).path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }
        return try await apiManager.updateResource(urlWithEndpoint, body: data)
    }

    func delete(id: Int) async throws {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.po(id).path)!
        try await apiManager.deleteResource(urlWithEndpoint)
    }
}
