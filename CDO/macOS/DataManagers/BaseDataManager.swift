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
    weak var delegate: DataManagerDelegate?

    func cachedItem(for id: Int) -> Any? { return nil }

    @MainActor
    func updateDelegate() {
        delegate?.didUpdateItems()
    }

    @MainActor
    func updatedItem(_ item: Any) {
        delegate?.didUpdateItem(item)
    }

    func load<T: Codable>(_ key: CacheKey) -> T? {
        CacheManager.shared.load(forKey: key)
    }

    func save(_ object: Codable, key: CacheKey) {
        CacheManager.shared.save(object, forKey: key)
    }
}
