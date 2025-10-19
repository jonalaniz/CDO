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
}
