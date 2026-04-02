//
//  SignInViewController.swift
//  CDO
//
//  Created by Jon Alaniz on 3/8/26.
//

import AppKit

class SignInViewController: NSViewController {
    @IBOutlet weak var urlTextField: NSTextField!
    @IBOutlet weak var apiKeyTextField: NSSecureTextField!
    @IBOutlet weak var loginButton: NSButton!
    @IBOutlet weak var errorLabel: NSTextField!

    let configurationManager = ConfigurationManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextField.delegate = self
        apiKeyTextField.delegate = self
    }

    @IBAction func loginPressed(_ sender: Any) {
        testServer()
    }

    private func updateLoginButton() {
        loginButton.isEnabled = !urlTextField.stringValue.isEmpty && !apiKeyTextField.stringValue.isEmpty
    }

    private func updateErrorButton(with text: String) {
        errorLabel.stringValue = text
        errorLabel.isHidden = true
    }

    private func testServer() {
        guard let _ = URL(string: urlTextField.stringValue)
        else {
            updateErrorButton(with: "Enter a valid URL")
            return
        }

        let server = Server(
            url: urlTextField.stringValue,
            secret: apiKeyTextField.stringValue
        )

        // TODO: Implement server testing
        configurationManager.save(Configuration(server: server))

    }
}

extension SignInViewController: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        updateLoginButton()
    }
}
