//
//  NSScrollView+VerticalScrollView.swift
//  CDO
//
//  Created by Jon Alaniz on 4/28/26.
//

import Cocoa

extension NSScrollView {
    static func verticalScroller() -> NSScrollView {
        let scrollView  = NSScrollView(frame: .zero)
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
}
