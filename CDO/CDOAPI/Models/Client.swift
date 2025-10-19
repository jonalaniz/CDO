//
//  Clients.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

struct ClientSummary: Codable {
    let id: Int?
    let firstName: String
    let lastName: String
    let address1: String?
    let address2: String?
    let city: String
    let state: String
    let zip: String?
}

struct Client: Codable {
    let id: Int?
    let startDate: Date?
    let ssn: String?
    let firstName: String
    let lastName: String
    let address1: String?
    let address2: String?
    let city: String
    let state: String
    let zip: String?
    let dob: Date?
    let driversLicense: String?
    let phone1: String?
    let phone1Identity: String?
    let phone2: String?
    let phone2Identity: String?
    let phone3: String?
    let phone3Identity: String?
    let email: String?
    let emailIdentity: String?
    let email2: String?
    let email2Identity: String?
    let disability: String
    let counselorID: Int?
    let counselor: String
    let counselorEmail: String?
    let counselorPhone: String?
    let counselorFax: String?
    let clientNotes: String?
    let conditions: String?
    let documentFolder: String?
    let active: Bool?
    let employmentGoal: String?
    let employerID: Int?
    let tier: String?
    let benefits: String?
    let criminalCharge: String?
    let education: String?
    let transportation: String?
    let checklistResumeRequred: Bool?
    let checklistResumeCompleted: Bool?
    let checklistVideoInterviewRequirement: Bool?
    let checklistVideoInterviewCompleted: Bool?
    let checklistReleasesCmp: Bool?
    let checklistOrientationCmp: Bool?
    let checklist1850DataSheetCmp: Bool?
    let checklistElevatorSpeechCmp: Bool?
    let race: String?
    let fluentLanguages: String?
    let premiums: String?
}
