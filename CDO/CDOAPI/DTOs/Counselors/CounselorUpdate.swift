//
//  CounselorUpdate.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct CounselorUpdate: Codable {
    var caseLoadID: Int?
    var name: String?
    var email: String?
    var phone: String?
    var fax: String?
    var notes: String?
    var secretaryName: String?
    var secretaryEmail: String?
}
