//
//  SASummary.swift
//  CDO
//
//  Created by Jon Alaniz on 4/2/26.
//

import Foundation

struct SASummary: Codable {
    // SA Specific
    let id: Int
    let serviceAuthorizationNumber: String
    let active: Bool
    let startDate: Date
    let endDate: Date
    let unitCost: Decimal?
    let description: String

    // Client Specific
    let clientID: Int?
    let clientName: String
    let caseID: String?

    // Counselor Specific
    let counselorID: Int?
    let counselorName: String
}
