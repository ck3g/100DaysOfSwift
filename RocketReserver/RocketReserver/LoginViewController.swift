//
//  LoginViewController.swift
//  RocketReserver
//
//  Created by Vitali Tatarintev on 07.04.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  @IBOutlet private var emailTextField: UITextField!
  @IBOutlet private var errorLabel: UILabel!
  @IBOutlet private var submitButton: UIButton!

  @IBAction private func submitTapped() {

  }

  @IBAction private func cancelTapped() {
    self.dismiss(animated: true)
  }

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
