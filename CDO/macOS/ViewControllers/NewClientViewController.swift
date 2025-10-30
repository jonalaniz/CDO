//
//  NewClientViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/27/25.
//

import Cocoa

enum PhoneType: String, CaseIterable {
    case cell
    case home
    case other
}

class NewClientViewController: NSViewController {
    // Basic Info
    @IBOutlet weak var basicInfoView: NSView!
    @IBOutlet weak var firstNameField: NSTextField!
    @IBOutlet weak var lastNameField: NSTextField!
    @IBOutlet weak var dobField: NSTextField!
    @IBOutlet weak var dlField: NSTextField!
    @IBOutlet weak var ssnField: NSTextField!
    @IBOutlet weak var raceField: NSTextField!

    // Address
    @IBOutlet weak var addressView: NSView!
    @IBOutlet weak var streetField: NSTextField!
    @IBOutlet weak var aptField: NSTextField!
    @IBOutlet weak var cityField: NSTextField!
    @IBOutlet weak var stateButton: NSPopUpButton!
    @IBOutlet weak var zipField: NSTextField!

    // Communication
    @IBOutlet weak var communicationsView: NSView!
    @IBOutlet weak var phoneOneField: NSTextField!
    @IBOutlet weak var phoneOneTypePopupButton: NSPopUpButton!
    @IBOutlet weak var phoneOneCustomTypeTextField: NSTextField!
    @IBOutlet weak var phoneTwoField: NSTextField!
    @IBOutlet weak var phoneTwoTypePopupButton: NSPopUpButton!
    @IBOutlet weak var phoneTwoCustomTypeTextField: NSTextField!
    @IBOutlet weak var phoneThreeField: NSTextField!
    @IBOutlet weak var phoneThreeTypePopupButton: NSPopUpButton!
    @IBOutlet weak var phoneThreeCustomTypeTextField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPersonalInfoView()
        // Do view setup here.
    }

    private func setupPersonalInfoView() {
        let color = NSColor.systemFill.withAlphaComponent(0.04).cgColor
        let borderColor = NSColor.systemFill.withAlphaComponent(0.05).cgColor

        basicInfoView.wantsLayer = true
        addressView.wantsLayer = true
        communicationsView.wantsLayer = true

        basicInfoView.layer?.borderColor = borderColor
        basicInfoView.layer?.borderWidth = 1

        basicInfoView.layer?.backgroundColor = color
        addressView.layer?.backgroundColor = color
        communicationsView.layer?.backgroundColor = color

        basicInfoView.layer?.cornerRadius = 8
        addressView.layer?.cornerRadius = 8
        communicationsView.layer?.cornerRadius = 8
    }

    private func setupPhoneTypePopupButtons() {
        [
            phoneOneTypePopupButton,
            phoneTwoTypePopupButton,
            phoneThreeTypePopupButton
        ].forEach {
            $0?.removeAllItems()
            for phoneType in PhoneType.allCases {
                $0?.addItem(withTitle: phoneType.rawValue)
            }
        }
    }

    @IBAction func phoneOneType(_ sender: NSPopUpButton) {
        guard let type = PhoneType(rawValue: sender.title)
        else { return }

        let isHidden = type != .other

        switch sender.tag {
        case 1: phoneOneCustomTypeTextField.isHidden = isHidden
        case 2: phoneTwoCustomTypeTextField.isHidden = isHidden
        case 3: phoneThreeCustomTypeTextField.isHidden = isHidden
        default: break
        }
    }

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(self)
    }
}

final class NewClientFactory {
}
