//
//  PlacementDetail.swift
//  CDO
//
//  Created by Jon Alaniz on 11/7/25.
//

import Foundation

struct PlacementDetail: Codable {
    // ID
    let id: Int

    // Placement Specific
    let active: Bool
    let placementNumber: Int?
    let position: String?
    let hireDate: Date?
    let endDate: Date?
    let daysOnJob: Int?
    let day1: String?
    let day2: String?
    let day3: String?
    let day4: String?
    let day5: String?
    let jobDuties: String?
    let workEnvironment: String?
    let accommodations: String?
    let hoursWorking: String?
    let workSchedule: String?
    let wages: String?
    let benefits: String?

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
    let employerPhone: String?
    let address1: String?
    let address2: String?
    let city: String?
    let state: String?
    let zip: String?
    let supervisorName: String?
    let supervisorEmail: String?
    let supervisorPhone: String?
    let website: String?
}
