//
//  Calendar.swift
//  CDO
//
//  Created by Jon Alaniz on 10/16/25.
//

import Foundation

struct ReminderDetail: Codable {
    let id: Int
    let date: Date?
    let clientID: Int?
    let description: String?
    let complete: Bool

    // ClientName is a computed property
    let clientName: String?
}
