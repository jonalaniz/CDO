//
//  NewCounselor.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct NewCounselor: Codable {
    // Required Fields
    let name: String

    // Optional Fields
    let caseLoadID: Int?
    let email: String?
    let phone: String?
    let fax: String?
    let notes: String?
    let secretaryName: String?
    let secretaryEmail: String?
}
