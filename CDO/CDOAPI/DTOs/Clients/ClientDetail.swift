//
//  ClientDetail.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

struct ClientDetail: Codable {
    let id: Int

    // MARK: - Required Fields
    let firstName: String
    let lastName: String
    let active: Bool
    let counselorID: Int?

    // MARK: - Parent Objects
    // TODO: Make sure this is the same object as is returned from the server
    let counselorReference: CounselorDetail?

    // MARK: - Child Objects
    let reminders: [ReminderDetail]?
    let sas: [SADetail]
    let placements: [PlacementDetail]

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
    let clientNotes: String?
    let conditions: String?
    let documentFolder: String?
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
}
