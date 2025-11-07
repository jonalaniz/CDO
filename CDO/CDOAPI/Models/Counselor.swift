//
//  Counselor.swift
//  CDO
//
//  Created by Jon Alaniz on 10/16/25.
//

import Foundation

// TODO: Add DTOs

struct Counselor: Codable {
    let id: Int
    let name: String
    let email: String?
    let phone: String?
    let fax: String?
    let notes: String?
    let secretaryName: String?
    let secretaryEmail: String?
}
