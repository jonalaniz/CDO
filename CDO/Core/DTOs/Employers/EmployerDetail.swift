//
//  EmployerDetail.swift
//  CDO
//
//  Created by Jon Alaniz on 4/2/26.
//

import Foundation

struct EmployerDetail: Codable {
    // Required Fields
    let id: Int

    // Optional Fields
    let name: String?
    let address1: String?
    let address2: String?
    let city: String?
    let state: String?
    let zip: String?
    let phone: String?
    let fax: String?
    let email: String?
    let website: String?
    let notes: String?
    let supervisorName: String?
    let supervisorPhone: String?
    let supervisorEmail: String?
}
