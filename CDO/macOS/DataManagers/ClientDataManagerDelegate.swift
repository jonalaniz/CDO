//
//  DataManagerDelegate.swift
//  CDO
//
//  Created by Jon Alaniz on 10/29/25.
//

import Foundation

@MainActor
protocol ClientManagerDelegate: AnyObject {
    func summariesDidChange()
    func summaryWasAdded(_ summary: ClientSummary)
    func detailDidChange(_ item: ClientDetail?)
    func itemWasDeleted(id: Int)
}
