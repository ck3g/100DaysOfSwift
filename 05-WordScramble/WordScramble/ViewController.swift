//
//  ViewController.swift
//  WordScramble
//
//  Created by Vitali Tatarintev on 09.03.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  var allWords = [String]()
  var usedWords = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(startGame))

    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      if let startWords  = try? String(contentsOf: startWordsURL) {
        allWords = startWords.components(separatedBy: "\n")
      }
    }

    if allWords.isEmpty {
      allWords = ["silkworm"]
    }

    startGame()
  }

  @objc func startGame() {
    title = allWords.randomElement()
    usedWords.removeAll(keepingCapacity: true)
    tableView.reloadData()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    usedWords.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]

    return cell
  }

  @objc func promptForAnswer() {
    let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
    ac.addTextField()

    let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
      guard let answer = ac?.textFields?[0].text else { return }
      self?.submit(answer)
    }

    ac.addAction(submitAction)
    present(ac, animated: true)
  }

  func submit(_ answer: String) {
    let lowerAnswer = answer.lowercased()

    guard isReal(word: lowerAnswer) else {
      showErrorMessage(title: "Word not recognized", message: "You can't just make them up, you know!")
      return
    }

    guard isOriginal(word: lowerAnswer) else {
      showErrorMessage(title: "Word already used", message: "Be more original!")
      return
    }

    guard isPossible(word: lowerAnswer) else {
      guard let title = title else { return }
      showErrorMessage(title: "Word not possible", message: "You can't spell that word from \(title.lowercased()).")
      return
    }

    usedWords.insert(answer, at: 0)

    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }

  func showErrorMessage(title: String, message: String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }

  func isPossible(word: String) -> Bool {
    guard var tempWord = title?.lowercased() else { return false }

    for letter in word {
      if let position = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: position)
      } else {
        return false
      }
    }

    return true
  }

  func isOriginal(word: String) -> Bool {
    return !usedWords.map { $0.lowercased() }.contains(word)
  }

  func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
  }

}

