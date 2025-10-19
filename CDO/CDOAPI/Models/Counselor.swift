//
//  Counselor.swift
//  CDO
//
//  Created by Jon Alaniz on 10/16/25.
//

import Foundation

struct Counselor: Codable {
    let id: Int
    let name: String
    let counselorEmail: String?
    let counselorPhone: String?
    let counselorFax: String?
    let counselorNotes: String?
    let secretaryName: String?
    let secretaryEmail: String?
}
