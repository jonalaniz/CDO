//
//  Note.swift
//  CDO
//
//  Created by Jon Alaniz on 4/28/26.
//

import Foundation

struct ClientNote: Codable {
    let id: Int
    let clientID: Int
    let date: Date
    let note: String
}
