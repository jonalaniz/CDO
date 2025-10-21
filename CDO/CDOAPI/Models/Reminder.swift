//
//  Calendar.swift
//  CDO
//
//  Created by Jon Alaniz on 10/16/25.
//

import Foundation

struct Reminder: Codable {
    let id: Int
    let actionDate: Date?
    let clientID: Int?
    let clientName: String?
    let employerID: Int?
    let description: String?
    let status: String?
    let complete: Bool?
}
