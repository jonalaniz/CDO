//
//  BaseContentViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/29/25.
//

import Cocoa

class BaseContentViewController: NSViewController {
    weak var coordinator: CDOCoordinator?

    override func viewDidAppear() {
        updateSubtitle(with: "Updating...")
    }

    func selectedObjectToRepresent(_ object: Any) {
        guard let window = view.window?.windowController as? WindowController
        else { return }
        window.updateInspectorRepresentedObject(with: object)
    }

    func updateSubtitle(with text: String) {
        guard let window = view.window?.windowController as? WindowController
        else { return }
        window.updateSubtitle(with: text)
    }
}
