//
//  Referral.swift
//  CDO
//
//  Created by Jon Alaniz on 11/7/25.
//

import Foundation

struct Referral: Codable {
    let id: String
    let placementNumber: Int?
    let employerID: String?
    let clientID: Int?
    let counselourID: Int?
    let poNumber: String?
    let supervisor: String?
    let supervisorEmail: String?
    let supervisorPhone: String?
    let position: String?
    let salary: String?
    let hireDate: Date?
    let endDate: Date?
    let daysonJob: Float?
    let clientName: String?
    let counselorName: String?
    let active: Bool?
    let website: String?
    let descriptionOfDuties: String?
    let numbersOfHoursWorking: String?
    let firstFiveDays1: String?
    let firstFiveDays2: String?
    let firstFiveDays3: String?
    let firstFiveDays4: String?
    let firstFiveDays5: String?
    let descriptionOfWorkSchedule: String?
    let hourlyOrMonthlyWages: String?
}
