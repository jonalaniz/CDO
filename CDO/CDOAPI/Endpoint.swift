//
//  Endpoint.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

enum Endpoint {
    case client(CustomStringConvertible)
    case clients
    case clientSummaries
    case counselor(CustomStringConvertible)
    case counselors
    case employer(CustomStringConvertible)
    case employers
    case pos
    case po(CustomStringConvertible)
    case reminder(CustomStringConvertible)
    case reminders
    case state(CustomStringConvertible)
    case states
    var path: String {
        switch self {
        case .client(let id): return "/api/clients/\(id)"
        case .clients: return "/api/clients/"
        case .clientSummaries: return "/api/clients/summaries"
        case .counselor(let id): return "/api/counselors/\(id)"
        case .counselors: return "/api/counselors"
        case .employer(let id): return "/api/employers/\(id)"
        case .employers: return "/api/employers"
        case .reminder(let id): return "/api/calendars/\(id)"
        case .reminders: return "/api/reminders"
        case .pos: return "/api/pos"
        case .po(let id): return "/api/pos/\(id)"
        case .state(let id): return "/api/states/\(id)"
        case .states: return "/api/states"
        }
    }
}
