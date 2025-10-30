//
//  Endpoint.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

enum Endpoint {
    case allClients
    case calendar(Int)
    case calendars
    case client(Int)
    case clients
    case counselors
    case employers

    var path: String {
        switch self {
        case .allClients: return "/api/clients/all"
        case .calendar(let id): return "/api/calendars/\(id)"
        case .calendars: return "/api/calendars"
        case .client(let id): return "/api/clients/\(id)"
        case .clients: return "/api/clients"
        case .counselors: return "/api/counselors"
        case .employers: return "/api/employers"
        }
    }
}
