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

  var guessWord = ""
  var guessedLetters: [String] = []
  let displayWordLabel = UILabel()

  override func loadView() {
    view = UIView()
    view.backgroundColor = .white

    configureDisplayWordLabel()
    configureKeyBoardView()
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
      keyButton.layer.cornerRadius = 5
      keyButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

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

    startGame()
  }

  func configureDisplayWordLabel() {
    displayWordLabel.translatesAutoresizingMaskIntoConstraints = false
    displayWordLabel.textAlignment = .center
    displayWordLabel.font = UIFont.systemFont(ofSize: 70)
    displayWordLabel.adjustsFontSizeToFitWidth = true
    displayWordLabel.text = guessWord
    view.addSubview(displayWordLabel)

    NSLayoutConstraint.activate([
      displayWordLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 150),
      displayWordLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
      displayWordLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
      displayWordLabel.heightAnchor.constraint(equalToConstant: 100)
    ])
  }

  func configureKeyBoardView() {
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

  func startGame() {
    guessWord = pickGuessWord()
    displayWordLabel.text = maskWord(guessWord)
    guessedLetters = []
  }

  func pickGuessWord() -> String {
    if let wordsFileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
      if let wordsContents = try? String(contentsOf: wordsFileURL) {
        var words = wordsContents.components(separatedBy: "\n")
        words.shuffle()

        return words[0]
      }
    }

    return "HANGMAN"
  }

  func maskWord(_ word: String) -> String {
    Array.init(repeating: "_", count: word.utf16.count).joined(separator: " ")
  }

  @objc func buttonTapped(_ sender: UIButton) {
    guard let letter = sender.titleLabel?.text else { return }

    sender.isEnabled = false
    sender.alpha = 0.3

    if guessWord.contains(letter) {
      guessedLetters.append(letter)
      displayWordLabel.text = replaceGuessedLetter(letter: letter, guessedLetters: guessedLetters)
    }
  }

  func replaceGuessedLetter(letter: String, guessedLetters: [String]) -> String {
    var characters = Array(guessWord).map({ String($0) })

    for i in 0..<characters.count {
      if !guessedLetters.contains(where: { $0 == characters[i] }) {
        characters[i] = "_"
      }
    }

    return characters.joined(separator: " ")
  }

}

