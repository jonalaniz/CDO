//
//  ClientAIManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/21/25.
//

import Foundation
import FoundationModels

final class ClientAIManager: NSObject {
    static let shared = ClientAIManager()
    let session = LanguageModelSession()

    private override init() {}

    func jobOpportunitiesFor(_ client: Client) {
        Task {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(client)
            let jsonString = String(data: jsonData, encoding: .utf8)!

            let prompt = """
            You are a career assistant AI. Here is a client profile:

            \(jsonString)

            Based on this information, suggest:
            - 3 suitable job roles for this client.
            - Resume tips and sections relevant to their skills.
            - Any other actionable advice for career development.
            """
            let response = try await session.respond(to: prompt)
            print(response.rawContent)
        }
    }
}
