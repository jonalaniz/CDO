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
    let ttw: Bool

    // MARK: - Parent Objects
    let counselorReference: CounselorUpdate?

    // MARK: - Child Objects
    let reminders: [Reminder]?
    let sas: [SADetail]
    let placements: [PlacementDetail]
    let clientNotes: [ClientNote]

    // MARK: - Optional Fields
    let startDate: Date?
    let caseID: String?
    let ssn: String?
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

    // Computed Properties

    var formattedAddress: String {
        let street = [
            address1,
            address2
        ].compactMap { $0 }.joined(separator: " ")

        let addressLines = [
            street.isEmpty ? nil : street,
            "\(city), \(state) \(zip ?? "")"
        ].compactMap { $0 }

        return addressLines.joined(separator: "\n")
    }

    var formattedDob: String {
        return dob?.formatted(
            date: .numeric,
            time: .omitted
        ) ?? ""
    }

    var formattedSSN: String {
        guard var string = ssn else { return "" }
        guard string.count == 9 else { return string }

        string.insert("-", at: string.index(string.startIndex, offsetBy: 5))
        string.insert("-", at: string.index(string.startIndex, offsetBy: 3))
        return string
    }
}
