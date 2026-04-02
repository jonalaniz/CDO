//
//  NewPlacement.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct NewPlacement: Codable {
    // Placement Specific Fields
    let active: Bool
    let placementNumber: Int?
    let position: String?
    let hireDate: Date?
    let endDate: Date?
    let daysOnJob: Float?
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
    let clientID: Int
    let clientName: String?

    // Counselor Fields
    let counselorID: Int?
    let counselorName: String?

    // Employer Fields/Object
    var employer: PlacementEmployerDTO
}

struct PlacementEmployerDTO: Codable {
    var employerID: Int?
    let name: String?
    let phone: String?
    let address1: String?
    let address2: String?
    let city: String?
    let state: String?
    let zip: String?
    let fax: String?
    let email: String?
    let website: String?
    let notes: String?
    let supervisorName: String?
    let supervisorPhone: String?
    let supervisorEmail: String?
}
