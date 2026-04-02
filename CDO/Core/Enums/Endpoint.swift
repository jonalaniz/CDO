//
//  Endpoint.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

enum Endpoint {
    case client(Int)
    case clients

    case counselor(Int)
    case counselors
    case counselorSummaries

    case employer(Int)
    case employers
    case employerSummaries

    case placement(Int)
    case placements
    case placementSummaries

    case reminder(Int)
    case reminders

    case serviceAuthorization(Int)
    case serviceAuthorizations

    case state(Int)
    case states

    var path: String {
        switch self {
        case .client(let id): return "/api/clients/\(id)"
        case .clients: return "/api/clients/"

        case .counselor(let id): return "/api/counselors/\(id)"
        case .counselors: return "/api/counselors"
        case .counselorSummaries: return "/api/counselors/summaries"

        case .employer(let id): return "/api/employers/\(id)"
        case .employers: return "/api/employers"
        case .employerSummaries: return "/api/employers/summaries"

        case .placement(let id): return "/api/placements/\(id)"
        case .placements: return "/api/placements"
        case .placementSummaries: return "/api/placements/summaries"

        case .reminder(let id): return "/api/reminders/\(id)"
        case .reminders: return "/api/reminders"

        case .serviceAuthorization(let id): return "/api/sas/\(id)"
        case .serviceAuthorizations: return "/api/sas"

        case .state(let id): return "/api/states/\(id)"
        case .states: return "/api/states"
        }
    }
}
