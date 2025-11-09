//
//  PO.swift
//  CDO
//
//  Created by Jon Alaniz on 11/7/25.
//

import Foundation

struct PO: Codable {
    let id: String
    let clientID: Int
    let description: String
    let startDate: Date
    let endDate: Date
    let office: String?
    let employerID: Int?
    let unitCost: Double?
    let unitOfMeasurement: String?
}
