//
//  Reminder.swift
//  CDO
//
//  Created by Jon Alaniz on 10/16/25.
//

import Foundation

struct Reminder: Codable {
    // Required Fields
    let id: Int
    let date: Date
    let description: String
    let clientID: Int
    let complete: Bool

    // ClientName is a computed property
    let clientName: String?

    // Computed Properties
    var formattedDate: String {
        return date.formatted(
            date: .numeric,
            time: .omitted
        )
    }
}
