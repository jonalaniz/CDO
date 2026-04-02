//
//  ClientSummary.swift
//  CDO
//
//  Created by Jon Alaniz on 3/7/26.
//

import Foundation

struct ClientSummary: Codable {
    // Required fields
    let id: Int
    let firstName: String
    let lastName: String
    let city: String
    let state: String
    let active: Bool
    let ttw: Bool

    // Optional Fields
    let address1: String?
    let address2: String?
    let zip: String?
    let counselorName: String?
    let phone: String?
    let phone2: String?
    let phone3: String?
    let employmentGoal: String?
    let caseID: String?


    func asClientMenuItem() -> ClientMenuItem {
        let nameArray = [lastName, firstName]
        let name = nameArray.compactMap(\.self).joined(separator: ", ")
        return ClientMenuItem(id: id, name: name)
    }
}
