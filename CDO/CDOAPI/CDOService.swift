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

    func fetchCalendars() async throws -> [Reminder] {
        let urlWithEndpoint = URL(string: baseURLString + Endpoint.calendars.path)!

        return try await apiManager.request(
            url: urlWithEndpoint,
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
