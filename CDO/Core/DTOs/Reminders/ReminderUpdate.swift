//
//  ReminderUpdate.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct ReminderUpdate: Codable {
    var date: Date?
    var description: String?
    var clientID: Int?
    var clientName: String?
    var complete: Bool?
}
