//
//  PlacementSummary.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct PlacementSummary: Codable {
    // ID
    let id: Int

    // Placement Specific
    let active: Bool
    let position: String?
    let hireDate: Date?
    let wages: String?

    // SA Specific
    let saID: Int?
    let saNumber: String?

    // Client Specific
    let clientID: Int?
    let clientName: String?

    // Counselor Specific
    let counselorID: Int?
    let counselorName: String?

    // Employer Specific
    let employerID: Int?
    let employerName: String?
    let supervisorName: String?
    let supervisorPhone: String?
    let website: String?
}
