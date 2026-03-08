//
//  NewClient.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct NewClient: Codable {
    // Required Creation Fields
    let firstName: String
    let lastName: String
    let counselorID: Int
    let city: String
    let state: String
    let disability: String

    // Optional Fields
    let startDate: Date?
    let ssn: Int?
    let caseID: String?
    let address1: String?
    let address2: String?
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
    let clientNotes: String?
    let conditions: String?
    let documentFolder: String?
    let active: Bool?
    let employmentGoal: String?
    let employerID: Int?
    let status: String?
    let benefits: String?
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
    let ttw: Bool
}
