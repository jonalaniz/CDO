//
//  CounselorSummary.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct CounselorSummary: Codable {
    // Required Fields
    let id: Int
    let name: String

    // Optional Fields
    let caseLoadID: Int
    let phone: String?
    let email: String?
    let secretaryName: String?
}
