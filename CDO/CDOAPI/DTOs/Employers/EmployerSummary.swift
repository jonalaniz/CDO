//
//  EmployerSummary.swift
//  CDO
//
//  Created by Jon Alaniz on 10/16/25.
//

import Foundation

struct EmployerSummary: Codable {
    let id: Int
    let name: String?
    let address1: String?
    let address2: String?
    let city: String?
    let state: String?
    let zip: String?
    let phone: String?
    let website: String?
    let notes: String?
    let supervisorName: String?
    let supervisorPhone: String?
}
