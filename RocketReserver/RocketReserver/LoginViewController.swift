//
//  LoginViewController.swift
//  RocketReserver
//
//  Created by Vitali Tatarintev on 07.04.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {
  @IBOutlet private var emailTextField: UITextField!
  @IBOutlet private var errorLabel: UILabel!
  @IBOutlet private var submitButton: UIButton!

  @IBAction private func submitTapped() {
    self.enableSubmitButton(false)

    guard let email = self.emailTextField.text else {
      self.errorLabel.text = "Please enter an email address."
      self.enableSubmitButton(true)
      return
    }

    guard self.validate(email: email) else {
      self.errorLabel.text = "Please enter a valid email."
      self.enableSubmitButton(true)
      return
    }

    Network.shared.apollo.perform(mutation: LoginMutation(email: email)) { [weak self] result in
      defer { self?.enableSubmitButton(true) }

      switch result {
      case .success(let graphQLResult):
        if let token = graphQLResult.data?.login {
          let keychain = KeychainSwift()
          keychain.set(token, forKey: LoginViewController.loginKeychainKey)
          self?.dismiss(animated: true)
        }

        if let errors = graphQLResult.errors {
          print("Errors from server: \(errors)")
        }
      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }

  @IBAction private func cancelTapped() {
    self.dismiss(animated: true)
  }

  static let loginKeychainKey = "login"

  override func viewDidLoad() {
    super.viewDidLoad()
    self.errorLabel.text = nil
    self.enableSubmitButton(true)
  }

  private func enableSubmitButton(_ isEnabled: Bool) {
    self.submitButton.isEnabled = isEnabled
    let buttonTitle = isEnabled ? "Submit" : "Submitting..."
    self.submitButton.setTitle(buttonTitle, for: .normal)
  }

  private func validate(email: String) -> Bool {
    return email.contains("@")
  }
}
