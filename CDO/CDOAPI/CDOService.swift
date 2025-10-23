//
//  CDOService.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

final class CDOService {
    static let shared = CDOService()

    private let apiManager = APIManager.shared

    private init() {}

    // TODO: Build out a way to input the address and remove this
    let baseURLString = "http://127.0.0.1:8080"

    func fetchCalendars(withClients: Bool = false) async throws -> [Reminder] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.calendars.path)!

        var components = URLComponents(url: urlWithEndpoint, resolvingAgainstBaseURL: true)
        if withClients { components?.queryItems = [URLQueryItem(name: "withClients", value: "true")] }
        guard let url = components?.url else { throw APIManagerError.invalidURL }

        return try await apiManager.request(
            url: url,
            httpMethod: .get,
            body: nil,
            headers: nil
        )
    }

    func fetchClients() async throws -> [ClientSummary] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.clients.path)!

        return try await apiManager.request(
            url: urlWithEndpoint,
            httpMethod: .get,
            body: nil,
            headers: nil
        )
    }

    func fetchClient(id: Int) async throws -> Client {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.client(id).path)!

        return try await apiManager.request(
            url: urlWithEndpoint,
            httpMethod: .get,
            body: nil,
            headers: nil
        )
    }

    func fetchCounselors() async throws -> [Counselor] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.counselors.path)!

        return try await apiManager.request(
            url: urlWithEndpoint,
            httpMethod: .get,
            body: nil,
            headers: nil
        )
    }

    func fetchEmployers() async throws -> [Employer] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.employers.path)!

        return try await apiManager.request(
            url: urlWithEndpoint,
            httpMethod: .get,
            body: nil,
            headers: nil
        )
    }

}
