//
//  PlacementUpdate.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct PlacementUpdate: Codable {
    // Placement Specific
    var active: Bool?
    var placementNumber: Int?
    var position: String?
    var hireDate: Date?
    var endDate: Date?
    var daysOnJob: Float?
    var day1: String?
    var day2: String?
    var day3: String?
    var day4: String?
    var day5: String?
    var jobDuties: String?
    var workEnvironment: String?
    var accommodations: String?
    var hoursWorking: String?
    var workSchedule: String?
    var wages: String?
    var benefits: String?

    // SA Specific
    var saID: Int?
    var saNumber: String?

    // Client Specific
    var clientID: Int?
    var clientName: String?

    // Counselor Specific
    var counselorID: Int?
    var counselorName: String?

    // Employer Specific
    var employerID: Int?
    var employerName: String?
    var employerPhone: String?
    var address1: String?
    var address2: String?
    var city: String?
    var state: String?
    var zip: String?
    var supervisorName: String?
    var supervisorEmail: String?
    var supervisorPhone: String?
    var website: String?
}
