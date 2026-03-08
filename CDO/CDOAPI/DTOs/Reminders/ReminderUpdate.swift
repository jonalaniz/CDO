//
//  ReminderUpdate.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct ReminderUpdate: Codable {
    var date: Date?
    var clientID: Int?
    var description: String?
    var complete: Bool?
}
