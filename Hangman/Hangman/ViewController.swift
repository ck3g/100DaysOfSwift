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
    keyboardView.backgroundColor = .systemGray6
    view.addSubview(keyboardView)

    let keyboardRow1View = UIView()
    keyboardRow1View.translatesAutoresizingMaskIntoConstraints = false
    keyboardView.addSubview(keyboardRow1View)

    let keyboardRow2View = UIView()
    keyboardRow2View.translatesAutoresizingMaskIntoConstraints = false
    keyboardView.addSubview(keyboardRow2View)

    let keyboardRow3View = UIView()
    keyboardRow3View.translatesAutoresizingMaskIntoConstraints = false
    keyboardView.addSubview(keyboardRow3View)

    let keyboardPadding: CGFloat = 5
    let rowHeight: CGFloat = 60

    NSLayoutConstraint.activate([
      keyboardView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
      keyboardView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: keyboardPadding),
      keyboardView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -keyboardPadding),
      keyboardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),

      keyboardRow3View.bottomAnchor.constraint(equalTo: keyboardView.bottomAnchor, constant: -keyboardPadding),
      keyboardRow3View.leadingAnchor.constraint(equalTo: keyboardView.leadingAnchor, constant: keyboardPadding),
      keyboardRow3View.trailingAnchor.constraint(equalTo: keyboardView.trailingAnchor, constant: -keyboardPadding),
      keyboardRow3View.heightAnchor.constraint(greaterThanOrEqualToConstant: rowHeight),

      keyboardRow2View.bottomAnchor.constraint(equalTo: keyboardRow3View.topAnchor, constant: -keyboardPadding),
      keyboardRow2View.leadingAnchor.constraint(equalTo: keyboardView.leadingAnchor, constant: keyboardPadding),
      keyboardRow2View.trailingAnchor.constraint(equalTo: keyboardView.trailingAnchor, constant: -keyboardPadding),
      keyboardRow2View.heightAnchor.constraint(greaterThanOrEqualToConstant: rowHeight),

      keyboardRow1View.bottomAnchor.constraint(equalTo: keyboardRow2View.topAnchor, constant: -keyboardPadding),
      keyboardRow1View.leadingAnchor.constraint(equalTo: keyboardView.leadingAnchor, constant: keyboardPadding),
      keyboardRow1View.trailingAnchor.constraint(equalTo: keyboardView.trailingAnchor, constant: -keyboardPadding),
      keyboardRow1View.heightAnchor.constraint(greaterThanOrEqualToConstant: rowHeight)
    ])

    addKeysToKeyboardRow(keys: keyboardRow1, rowView: keyboardRow1View, leadingPadding: 5)
    addKeysToKeyboardRow(keys: keyboardRow2, rowView: keyboardRow2View, leadingPadding: 22)
    addKeysToKeyboardRow(keys: keyboardRow3, rowView: keyboardRow3View, leadingPadding: 56)
  }

  func addKeysToKeyboardRow(keys: [String], rowView: UIView, leadingPadding: CGFloat = 5) {
    let buttonWidth: CGFloat = ((UIScreen.main.bounds.size.width - 20) / 13).rounded()
    var leadingAnchor = rowView.leadingAnchor
    var firstButton = true

    for button in keys {
      let keyButton = UIButton(type: .system)
      keyButton.translatesAutoresizingMaskIntoConstraints = false
      keyButton.setTitle(button, for: .normal)
      keyButton.backgroundColor = .systemGray3
      keyButton.setTitleColor(.white, for: .normal)

      rowView.addSubview(keyButton)

      NSLayoutConstraint.activate([
        keyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: firstButton ? leadingPadding : 5),
        keyButton.topAnchor.constraint(equalTo: rowView.topAnchor, constant: 5),
        keyButton.bottomAnchor.constraint(equalTo: rowView.bottomAnchor, constant: -5),
        keyButton.widthAnchor.constraint(equalToConstant: buttonWidth)
      ])

      firstButton = false
      leadingAnchor = keyButton.trailingAnchor
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

  }


}

