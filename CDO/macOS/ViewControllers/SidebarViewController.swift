//
//  SidebarViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/17/25.
//

import Cocoa

class SidebarViewController: NSViewController {
    @IBOutlet weak var outlineView: NSOutlineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outlineView.dataSource = self
        outlineView.delegate = self
        outlineView.expandItem(nil, expandChildren: true)
        // Do view setup here.
    }
}

extension SidebarViewController: NSOutlineViewDataSource, NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {

        // Root (item == nil), return the number of source types (2)
        guard let source = item as? Source
        else { return Source.allCases.count }

        // Cast as a source, return the number of children
        print(source.children.count)
        return source.children.count
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {

        // Root (item == nil), return the specfic source at the index
        guard let source = item as? Source
        else { return Source.allCases[index] }

        // Cast as a source, we return the child at the index
        return source.children[index]
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        guard let _ = item as? Source else { return false }
        return true
    }

    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        return item is Source
    }

    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        switch item {
        case is Source.MainSource, is Source.AdministrativeSource:
            return true
        default:
            return false
        }
    }

    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {

        var text: String
        var identifier: NSUserInterfaceItemIdentifier

        switch item {
        case let item as Source:
            text = item.text
            identifier = item.identifier
        case let item as Source.MainSource:
            text = item.text
            identifier = item.identifier
        case let item as Source.AdministrativeSource:
            text = item.text
            identifier = item.identifier
        default: return nil
        }

        guard let view = outlineView.makeView(withIdentifier: identifier, owner: self) as? NSTableCellView
        else { return nil }

        view.textField?.stringValue = text

        return view
    }
}
