//
//  ReminderViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 10/24/25.
//

import Cocoa

final class ReminderViewController: NSViewController {
    @IBOutlet weak var clientList: NSPopUpButton!
    @IBOutlet weak var datePicker: NSDatePicker!
    @IBOutlet weak var deleteButton: NSButton!
    @IBOutlet weak var saveButton: NSButton!
    @IBOutlet var descriptionTextField: NSTextView!
    @IBOutlet weak var completedCleckbox: NSButton!

    let clientManager = ClientManager.shared

    override func viewDidLoad() {
        descriptionTextField.delegate = self
        setupMenu()
    }

    func setupMenu() {
        clientList.menu?.removeAllItems()
        let menu = NSMenu()
        for client in clientManager.clientMenuArray() {
            let menuItem = NSMenuItem(
                title: client.name,
                action: nil,
                keyEquivalent: ""
            )
            menuItem.tag = client.id
            menu.addItem(menuItem)
        }
        clientList.menu = menu
    }

    var modified = false {
        didSet { saveButton.isEnabled = modified }
    }

    override var representedObject: Any? {
        didSet {
            guard let reminder = representedObject as? Reminder else { return }
            updateUI(with: reminder)
        }
    }

    func updateUI(with reminder: Reminder) {
        // Select a client based on the date
        descriptionTextField.string = reminder.description ?? ""
        datePicker.dateValue = reminder.date ?? Date()
        completedCleckbox.state = reminder.complete ? .on : .off
        selectClient(id: reminder.clientID)
    }

    func selectClient(id: Int?) {
        guard let id = id else { return }
        setupMenu()
        clientList.selectItem(withTag: id)
    }

    @IBAction func dateChanged(_ sender: Any) {
    }

    @IBAction func deferredClicked(_ sender: NSSegmentedControl) {
        let selection = sender.selectedSegment
    }

    @IBAction func deleteClicked(_ sender: Any) {
    }

    @IBAction func saveClicked(_ sender: Any) {
    }
}

extension ReminderViewController: NSTextViewDelegate {
    func textDidChange(_ notification: Notification) {
        print(descriptionTextField.textStorage?.string)
    }
}
