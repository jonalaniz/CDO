//
//  CRUDService.swift
//  CDO
//
//  Created by Jon Alaniz on 11/8/25.
//

import Foundation

protocol CRUDService {
    associatedtype Model: Codable
    associatedtype Detail: Codable
    func fetchAll() async throws -> [Model]
    func fetch(id: Int) async throws -> Detail
    func create(_ item: Codable) async throws -> Detail
    func update(id: Int, with item: Codable) async throws
    func delete(id: Int) async throws
    func updateBaseAddress(_ string: String)
}
