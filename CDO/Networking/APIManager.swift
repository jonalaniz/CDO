//
//  APIManager.swift
//  Scouter
//
//  Created by Jon Alaniz on 9/1/24.
//

import Foundation

final class APIManager {
    public internal(set) var session = URLSession.shared

    static let shared = APIManager()

    private init() {}

    func createResource<T>(_ url: URL,
                           body: Data) async throws -> T where T: Decodable, T: Encodable {
        return try await request(url: url, method: .post, body: body)
    }

    func fetchResource<T>(_ url: URL) async throws -> T where T: Decodable, T: Encodable {
        return try await request(url: url, method: .get)
    }

    func updateResource<T>(_ url: URL,
                           body: Data) async throws -> T where T: Decodable, T: Encodable {
        return try await request(url: url, method: .patch, body: body)
    }

    func deleteResource(_ url: URL) async throws {
        try await request(url: url, method: .delete)
    }

    private func request(url: URL,
                         method: ServiceMethod,
                         body: Data? = nil,
                         headers: [String: String]? = nil
    ) async throws {
        let request = makeRequest(url: url, method: method, body: body, headers: headers)

        let dataWithResponse: (data: Data, repsonse: URLResponse) = try await session.data(for: request)

        guard let response = dataWithResponse.repsonse as? HTTPURLResponse
        else {
            throw APIManagerError.conversionFailedToHTTPURLResponse
        }

        try response.statusCodeChecker()
    }

    private func request<T>(url: URL,
                            method: ServiceMethod,
                            body: Data? = nil,
                            headers: [String: String]? = nil
    ) async throws -> T where T: Decodable, T: Encodable {
        let request = makeRequest(url: url, method: method, body: body, headers: headers)

        return try await self.decodeResponse(session.data(for: request))
    }

    private func makeRequest(url: URL,
                             method: ServiceMethod,
                             body: Data?,
                             headers: [String: String]?
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body = body, method != .get { request.httpBody = body }
        request.addHeaders(from: headers)
        return request
    }

    private func decodeResponse<T: Decodable>(
        _ dataWithResponse: (data: Data, response: URLResponse)
    ) async throws -> T {
        guard let response = dataWithResponse.response as? HTTPURLResponse else {
            throw APIManagerError.conversionFailedToHTTPURLResponse
        }

        try response.statusCodeChecker()

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(
                T.self,
                from: dataWithResponse.data)
        } catch {
            throw APIManagerError.serializaitonFailed
        }
    }
}
