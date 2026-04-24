//
//  SidebarViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/17/25.
//

import Cocoa

final class SidebarViewController: NSViewController {
    private var outlineView = NSOutlineView(frame: .zero)
    private var hasSelectedDefault = false

    weak var delegate: SidebarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = CDOCoordinator.shared
        setupOutlineView()
    }

    override func viewDidAppear() {
        selectDefaultItem()
    }

    private func setupOutlineView() {
        outlineView.register(
            NSNib(nibNamed: "SidebarCell", bundle: nil),
            forIdentifier: SourceItem.administrative.identifier
        )

        outlineView.register(
            NSNib(nibNamed: "SidebarCell", bundle: nil),
            forIdentifier: SourceItem.clients.identifier
        )

        // Style OutlineView
        outlineView.style = .sourceList
        outlineView.headerView = nil
        outlineView.rowSizeStyle = .default
        outlineView.floatsGroupRows = false

        // Wire Up OutlineView
        outlineView.dataSource = self
        outlineView.delegate = self

        // Create ScrollView to contain OutlineView
        let scrollView = NSScrollView(frame: .zero)
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false
        scrollView.documentView = outlineView

        // Add Column
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Column"))
        outlineView.addTableColumn(column)
        outlineView.outlineTableColumn = column

        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func selectDefaultItem() {
        guard hasSelectedDefault == false else { return }
        outlineView.expandItem(nil, expandChildren: true)
        outlineView.selectRowIndexes(
            IndexSet(integer: outlineView.row(forItem: SourceItem.reminders)),
            byExtendingSelection: false
        )
        hasSelectedDefault = true
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
        else { return SourceItem.rootItems.count }

        // Cast as a source, return the number of children
        return source.children.count
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        // Root (item == nil), return the specfic source at the index
        guard let source = item as? SourceItem
        else { return SourceItem.rootItems[index] }

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
        guard
            let item = item as? SourceItem,
            let cell = outlineView.makeView(
                withIdentifier: item.identifier, owner: self
            ) as? NSTableCellView
        else { return nil }

        cell.textField?.stringValue = item.rawValue
        cell.imageView?.image = item.image

        return cell
    }
}
