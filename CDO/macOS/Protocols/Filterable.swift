//
//  Filterable.swift
//  CDO
//
//  Created by Jon Alaniz on 10/30/25.
//

import Foundation

protocol Filterable {
    var isFiltered: Bool { get }
    func toggleFilter()
}
