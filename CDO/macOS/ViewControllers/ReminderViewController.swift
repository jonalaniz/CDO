//
//  ReminderViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/24/25.
//

import Cocoa

final class ReminderViewController: NSViewController {
    @IBOutlet weak var clientList: NSPopUpButton!
    @IBOutlet weak var descriptionField: NSTextField!
    @IBOutlet weak var datePicker: NSDatePicker!
    @IBOutlet weak var completeButton: NSButton!

    override var representedObject: Any? {
        didSet {
            guard let reminder = representedObject as? Reminder else { return }
            updateUI(with: reminder)
        }
    }

    func updateUI(with reminder: Reminder) {
        // Select a client based on the date
        descriptionField.stringValue = reminder.description ?? ""
        datePicker.dateValue = reminder.date ?? Date()
        completeButton.title = reminder.complete ? "Uncomplete" : "Complete"
    }

    @IBAction func dateChanged(_ sender: Any) {
    }

    @IBAction func deferredClicked(_ sender: NSSegmentedControl) {
    }

    @IBAction func completionClicked(_ sender: Any) {
    }

    @IBAction func deleteClicked(_ sender: Any) {
    }
}
