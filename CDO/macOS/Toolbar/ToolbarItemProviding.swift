//
//  ToolbarItemProviding.swift
//  CDO
//
//  Created by Jon Alaniz on 5/8/26.
//

import Cocoa

protocol ToolbarItemProviding: AnyObject {
    func makeRemindersItem() -> NSToolbarItem
}
