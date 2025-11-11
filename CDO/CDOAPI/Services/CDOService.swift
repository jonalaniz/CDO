//
//  CDOService.swift
//  CDO
//
//  Created by Jon Alaniz on 10/15/25.
//

import Foundation

final class CDOService {
    static let shared = CDOService()

    private let apiManager = APIManager.shared
    private let baseURLString = "http://127.0.0.1:8080"

    private init() {}
}
