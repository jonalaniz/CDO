//
//  Clients.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

struct ClientSummary: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let address1: String?
    let address2: String?
    let city: String
    let state: String
    let zip: String?
}

struct Client: Codable {
    // MARK: - Required Fields

    let id: Int
    let firstName: String
    let lastName: String
    let counselor: String

    // MARK: - Optional Child Fields
    let reminders: [Reminder]

    // MARK: - Optional Fields
    let startDate: Date?
    let ssn: String?
    let caseID: String?
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
    let counselorEmail: String?
    let counselorPhone: String?
    let counselorFax: String?
    let clientNotes: String?
    let conditions: String?
    let documentFolder: String?
    let active: Bool?
    let employmentGoal: String?
    let employerID: Int?
    let status: String?
    let benefits: Benefit?
    let criminalCharge: String?
    let education: String?
    let transportation: String?
    let resumeRequired: Bool?
    let resumeCompleted: Bool?
    let videoInterviewRequired: Bool?
    let videoInterviewCompleted: Bool?
    let releasesCompleted: Bool?
    let orientationCompleted: Bool?
    let dataSheetCompleted: Bool?
    let elevatorSpeechCompleted: Bool?
    let race: String?
    let fluentLanguages: String?
    let premiums: String?
}
