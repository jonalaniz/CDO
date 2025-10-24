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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func updateUI(with: Reminder) {
        
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
