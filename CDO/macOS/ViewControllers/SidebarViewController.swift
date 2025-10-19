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
    }
}

extension SidebarViewController: NSOutlineViewDataSource, NSOutlineViewDelegate {
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let item = outlineView.item(atRow: outlineView.selectedRow) else { return }
        switch item {
        case let item as MainSource:
            print(item.rawValue)
        case let item as AdministrativeSource:
            print(item.rawValue)
        default: return
        }
    }

    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        // Root (item == nil), return the number of source types (2)
        guard let source = item as? Source
        else { return Source.allCases.count }

        // Cast as a source, return the number of children
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
        guard item is Source else { return true }
        return false
    }

    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var text: String
        var image: NSImage?
        var identifier: NSUserInterfaceItemIdentifier

        switch item {
        case let item as Source:
            text = item.rawValue
            identifier = item.identifier
            image = item.image
        case let item as MainSource:
            text = item.rawValue
            identifier = item.identifier
            image = item.image
        case let item as AdministrativeSource:
            text = item.rawValue
            identifier = item.identifier
            image = item.image
        default: return nil
        }

        guard let view = outlineView.makeView(withIdentifier: identifier, owner: self) as? NSTableCellView
        else { return nil }

        view.textField?.stringValue = text
        view.imageView?.image = image

        return view
    }
}
