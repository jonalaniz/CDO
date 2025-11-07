//
//  Employer.swift
//  CDO
//
//  Created by Jon Alaniz on 10/16/25.
//

import Foundation

struct Employer: Codable {
    let id: Int
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
    let supervisor: String?
    let supervisorPhone: String?
    let supervisorEmail: String?
}
