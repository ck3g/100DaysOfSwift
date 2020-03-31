//
//  ViewController.swift
//  Hangman
//
//  Created by Vitali Tatarintev on 30.03.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let keyboardRow1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
  let keyboardRow2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
  let keyboardRow3 = ["Z", "X", "C", "V", "B", "N", "M"]

  override func loadView() {
    view = UIView()
    view.backgroundColor = .white

    let keyboardView = UIView()
    keyboardView.translatesAutoresizingMaskIntoConstraints = false
    keyboardView.backgroundColor = .systemTeal
    view.addSubview(keyboardView)

    NSLayoutConstraint.activate([
      keyboardView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
      keyboardView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 5),
      keyboardView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -5),
      keyboardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
    ])
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

