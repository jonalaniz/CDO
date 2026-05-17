//
//  SADetail.swift
//  CDO
//
//  Created by Jon Alaniz on 11/7/25.
//

import Foundation

struct SADetail: Codable {
    // SA Specific
    let id: Int
    let serviceAuthorizationNumber: String
    let office: String?
    let description: String
    let startDate: Date
    let endDate: Date
    let unitCost: Double?
    let unitOfMeasurement: String?

    // Client Specific
    let clientID: Int?
    let clientName: String
    let caseID: String

    // Counselor Specific
    let counselorID: Int?
    let counselorName: String
    let secretraryName: String?

    var formattedEndDate: String {
        return "Valid till \(formatted(endDate))"
    }

    private func formatted(_ date: Date) -> String {
        return date.formatted(date: .numeric, time: .omitted)
    }
}
