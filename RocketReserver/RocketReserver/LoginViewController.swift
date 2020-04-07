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
  @IBOutlet private var sumbitButton: UIButton!

  @IBAction private func submitTapped() {

  }

  @IBAction private func cancelTapped() {
    self.dismiss(animated: true)
  }
}
