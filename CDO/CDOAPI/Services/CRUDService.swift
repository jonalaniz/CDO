//
//  CRUDService.swift
//  CDO
//
//  Created by Jon Alaniz on 11/8/25.
//

import Foundation

protocol CRUDService {
    associatedtype Model: Codable
    func fetchAll() async throws -> [Model]
    func fetch(id: CustomStringConvertible) async throws -> Model
    func create(_ item: Codable) async throws -> Model
    func update(id: CustomStringConvertible, with item: Codable) async throws -> Model
    func delete(id: Int) async throws
}
