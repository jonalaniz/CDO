//
//  NewReminder.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct NewReminder: Codable {
    // Required Creation Fields
    let date: Date
    let description: String

    // Optional Fields
    let clientID: Int?
    let clientName: String?
    let complete: Bool?
}
