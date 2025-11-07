//
//  Endpoint.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

enum Endpoint {
    case clients
    case calendar(Int)
    case calendars
    case client(Int)
    case clientSummaries
    case counselors
    case employers
    case states

    var path: String {
        switch self {
        case .clients: return "/api/clients/"
        case .calendar(let id): return "/api/calendars/\(id)"
        case .calendars: return "/api/reminders"
        case .client(let id): return "/api/clients/\(id)"
        case .clientSummaries: return "/api/clients/summaries"
        case .counselors: return "/api/counselors"
        case .employers: return "/api/employers"
        case .states: return "/api/states"
        }
    }
}
