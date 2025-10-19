//
//  Endpoint.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

enum Endpoint {
    case calendars
    case clients
    case counselors
    case employers

    var path: String {
        var endpoint: String

        switch self {
        case .calendars: endpoint = "/api/calendars"
        case .clients: endpoint = "/api/clients"
        case .counselors: endpoint = "/api/counselors"
        case .employers: endpoint = "/api/employers"
        }

        return endpoint
    }
}
