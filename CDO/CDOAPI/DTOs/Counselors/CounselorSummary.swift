//
//  CounselorSummary.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct CounselorSummary: Codable {
    let id: Int
    let caseLoadID: Int
    let name: String
    let email: String?
    let phone: String?
    let secretaryName: String?
}
