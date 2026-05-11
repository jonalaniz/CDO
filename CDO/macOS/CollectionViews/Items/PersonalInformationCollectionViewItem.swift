//
//  PersonalInformationCell.swift
//  CDO
//
//  Created by Jon Alaniz on 5/8/26.
//

import Cocoa

final class PersonalInformationCollectionViewItem: ClientCardItem {
//    let glassView = NSGlassEffectView()
//    let button = NSButton(
//        image: NSImage(systemSymbolName: "pencil", accessibilityDescription: "edit") ?? NSImage(),
//        target: nil,
//        action: nil
//    )
}

final class LabelPairView: NSView {
    let headerField = NSTextField(labelWithString: "")
    let contentField = NSTextField(labelWithString: "")
}
