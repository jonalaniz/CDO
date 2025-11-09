//
//  Tier.swift
//  CDO
//
//  Created by Jon Alaniz on 10/21/25.
//

import Foundation

/// This is titled "Tier" within the database
enum Status: String, Codable {
    case ssa = "SSA"
    case vr1 = "VR1"
    case vr2 = "VR2"
    case sup1 = "SUP1"
    case sup2 = "SUP2"
}
