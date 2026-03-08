//
//  Counselor.swift
//  CDO
//
//  Created by Jon Alaniz on 10/16/25.
//

import Foundation

struct CounselorDetail: Codable {
    let id: Int
    let caseLoadID: Int?
    let name: String
    let phone: String?
    let email: String?
    let fax: String?
    let notes: String?
    let secretaryName: String?
    let secretaryEmail: String?
    let clients: [ClientSummary]
    let invoices: [SADetail]
}
