//
//  SidebarViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/17/25.
//

import Cocoa

final class SidebarViewController: NSViewController {
    @IBOutlet weak var outlineView: NSOutlineView!

    weak var delegate: SidebarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = CDOCoordinator.shared
        outlineView.dataSource = self
        outlineView.delegate = self
        outlineView.expandItem(nil, expandChildren: true)
        selectDefaultItem()
    }

    private func selectDefaultItem() {
        let row = outlineView.row(forItem: SourceItem.reminders)
        outlineView.selectRowIndexes(IndexSet(integer: row), byExtendingSelection: false)
    }
}

extension SidebarViewController: NSOutlineViewDataSource, NSOutlineViewDelegate {
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let item = outlineView.item(atRow: outlineView.selectedRow) as? SourceItem
        else { return }
        delegate?.selectionMade(item)
    }

    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        // Root (item == nil), return the number of source types
        guard let source = item as? SourceItem
        else {
            return SourceItem.rootItems.count
        }

        // Cast as a source, return the number of children
        return source.children.count
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        // Root (item == nil), return the specfic source at the index
        guard let source = item as? SourceItem
        else {
            let headers: [SourceItem] = [.main, .administrative]
            return headers[index]
        }

        // Cast as a source, we return the child at the index
        return source.children[index]
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        guard let item = item as? SourceItem else { return false }
        return !item.children.isEmpty
    }

    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        guard let item = item as? SourceItem
        else { return false }
        return item.isHeader
    }

    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        guard let item = item as? SourceItem
        else { return false }
        return !item.isHeader
    }

    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var text: String
        var image: NSImage?
        var identifier: NSUserInterfaceItemIdentifier

        guard let item = item as? SourceItem
        else { return nil }

        text = item.rawValue
        identifier = item.identifier

        if !item.isHeader {
            if let symbol = item.image { image = symbol }
        }

        guard let view = outlineView.makeView(withIdentifier: identifier, owner: self) as? NSTableCellView
        else { return nil }

        view.textField?.stringValue = text
        view.imageView?.image = image

        return view
    }
}
