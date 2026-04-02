//
//  ClientUpdate.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct ClientUpdate: Codable {
    var firstName: String?
    var lastName: String?
    var ttw: Bool?
    var city: String?
    var disability: String?
    var state: String?
    var ssn: String?
    var caseID: String?
    var address1: String?
    var address2: String?
    var zip: String?
    var dob: Date?
    var startDate: Date?
    var driversLicense: String?
    var phone1: String?
    var phone1Identity: String?
    var phone2: String?
    var phone2Identity: String?
    var phone3: String?
    var phone3Identity: String?
    var email: String?
    var emailIdentity: String?
    var email2: String?
    var email2Identity: String?
    var counselorID: Int?
    var clientNotes: String?
    var conditions: String?
    var documentFolder: String?
    var active: Bool?
    var employmentGoal: String?
    var employerID: Int?
    var status: String?
    var benefits: String?
    var criminalCharge: String?
    var education: String?
    var transportation: String?
    var resumeRequired: Bool?
    var resumeCompleted: Bool?
    var videoInterviewRequired: Bool?
    var videoInterviewCompleted: Bool?
    var releasesCompleted: Bool?
    var orientationCompleted: Bool?
    var dataSheetCompleted: Bool?
    var elevatorSpeechCompleted: Bool?
    var race: String?
    var fluentLanguages: String?
    var premiums: String?
}
