//
//  CounselorUpdate.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct CounselorUpdate: Codable {
    var name: String?
    var caseLoadID: Int?
    var email: String?
    var phone: String?
    var fax: String?
    var notes: String?
    var secretaryName: String?
    var secretaryEmail: String?
}
