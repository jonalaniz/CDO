//
//  NewItemProviding.swift
//  CDO
//
//  Created by Jon Alaniz on 10/29/25.
//

import AppKit

protocol ItemCreationProviding {
    func makeCreationViewController(using storyboard: NSStoryboard) -> NSViewController?
}
