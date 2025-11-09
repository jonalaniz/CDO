//
//  Endpoint.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

enum Endpoint {
    case clients
    case client(CustomStringConvertible)
    case clientSummaries
    case counselors
    case employers
    case pos
    case po(String)
    case reminder(Int)
    case reminders
    case states
    case state(CustomStringConvertible)

    var path: String {
        switch self {
        case .clients: return "/api/clients/"
        case .client(let id): return "/api/clients/\(id)"
        case .clientSummaries: return "/api/clients/summaries"
        case .counselors: return "/api/counselors"
        case .employers: return "/api/employers"
        case .reminder(let id): return "/api/calendars/\(id)"
        case .reminders: return "/api/reminders"
        case .pos: return "/api/pos"
        case .po(let id): return "/api/pos/\(id)"
        case .states: return "/api/states"
        case .state(let id): return "/api/states/\(id)"
        }
    }
}
