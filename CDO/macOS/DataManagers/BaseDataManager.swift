//
//  BaseDataManager.swift
//  CDO
//
//  Created by Jon Alaniz on 10/29/25.
//

import Foundation

protocol DataManagerDelegate: AnyObject {
    func didUpdateItem(_ item: Any)
    func didUpdateItems()
    func didSelect()
}

class BaseDataManager: NSObject {
    let service = CDOService.shared
    weak var delegate: DataManagerDelegate?

    func cachedItem(for id: Int) -> Any? { return nil }

    @MainActor
    func updatedItem(_ item: Any) {
        print("kkkalled")
        delegate?.didUpdateItem(item)
    }
}
