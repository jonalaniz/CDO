//
//  EmployerDTO.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct EmployerDTO: Codable {
    var name: String?
    var address1: String?
    var address2: String?
    var city: String?
    var state: String?
    var zip: String?
    var phone: String?
    var fax: String?
    var email: String?
    var website: String?
    var notes: String?
    var supervisorName: String?
    var supervisorPhone: String?
    var supervisorEmail: String?
}
