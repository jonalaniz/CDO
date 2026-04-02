//
//  SAUpdate.swift
//  CDO
//
//  Created by Jon Alaniz on 4/2/26.
//

import Foundation

struct SAUpdate: Codable {
    // SA Specific
    let serviceAuthorizationNumber: String?
    let office: String?
    let description: String?
    let startDate: Date?
    let endDate: Date?
    let unitCost: Decimal?
    let unitOfMeasurement: String?

    // Client Specific
    let clientID: Int?
    let clientName: String?
    let caseID: String?

    // Counselor Specific
    let counselorID: Int?
    let counselorName: String?
    let secretaryName: String?
}
