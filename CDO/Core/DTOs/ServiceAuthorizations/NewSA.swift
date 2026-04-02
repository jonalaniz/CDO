//
//  NewSA.swift
//  CDO
//
//  Created by Jon Alaniz on 4/2/26.
//

import Foundation

struct NewSA: Codable {
    // SA Specific
    let serviceAuthorizationNumber: String
    let office: String?
    let description: String
    let startDate: Date
    let endDate: Date
    let unitCost: Decimal?
    let unitOfMeasurement: String?

    // Client Specific
    let clientID: Int
    let clientName: String
    let caseID: String

    // Couselor Specific
    let counselorID: Int?
    let counselorName: String
    let secretaryName: String?
}
