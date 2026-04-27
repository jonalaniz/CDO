//
//  NotesViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 4/25/26.
//

import Cocoa

final class NotesViewController: NSViewController {
    private let notesView = NSTextView()
    private var scrollView = NSScrollView.verticalScroller()

    override func viewDidLoad() {
        notesView.isEditable = false
        notesView.drawsBackground = false
        constrainUI()
    }

    private func constrainUI() {
        scrollView.documentView = notesView
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }

    func setNotes(_ string: String?) {
        notesView.string = string ?? ""
        scrollView.documentView?.scroll(.zero)
    }
}

extension NSScrollView {
    static func verticalScroller() -> NSScrollView {
        let scrollView  = NSScrollView(frame: .zero)
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
}
