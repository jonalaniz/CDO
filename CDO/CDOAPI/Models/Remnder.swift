//
//  Calendar.swift
//  CDO
//
//  Created by Jon Alaniz on 10/16/25.
//

import Foundation

struct Remnder: Codable {
    let id: Int
    let actionDate: Date?
    let clientID: Int?
    let employerID: Int?
    let description: String?
    let status: String?
    let complete: Bool?
}
