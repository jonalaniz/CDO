//
//  ClientsService.swift
//  CDO
//
//  Created by Jon Alaniz on 11/9/25.
//

import Foundation

final class ClientService: CRUDService {
    static let shared = ClientService()

    typealias Model = ClientSummary
    typealias Detail = ClientDetail

    private let apiManager = APIManager.shared
    private var baseURLString = ""

    private init() {}

    func fetchAll() async throws -> [Model] {
        let fullAddress = URL(string: baseURLString + Endpoint.clients.path)!
        return try await apiManager.fetchResource(fullAddress)
    }

    func fetch(id: Int) async throws -> Detail {
        let fullAddress = URL(string: baseURLString + Endpoint.client(id).path)!
        return try await apiManager.fetchResource(fullAddress)
    }

    func create(_ item: Codable) async throws -> Detail {
        let fullAddress = URL(string: baseURLString + Endpoint.clients.path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }

        return try await apiManager.createResource(fullAddress, body: data)
    }

    func update(id: Int, with item: Codable) async throws {
        let fullAddress = URL(string: baseURLString + Endpoint.client(id).path)!
        guard let data = try? JSONEncoder().encode(item)
        else { throw APIManagerError.unableToEncodeObject }
        try await apiManager.updateResource(fullAddress, body: data)
    }

    func delete(id: Int) async throws {
        let fullAddress = URL(string: baseURLString + Endpoint.client(id).path)!
        try await apiManager.deleteResource(fullAddress)
    }

    // MARK: - Convenience Methods
    func updateBaseAddress(_ string: String) {
        baseURLString = string
    }
}
