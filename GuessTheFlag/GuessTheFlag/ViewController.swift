//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Vitali Tatarintev on 01.03.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!

  var countries = [String]()
  var score = 0
  var correctAnswer = 0
  var questionsAnswered = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1

    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderColor = UIColor.lightGray.cgColor

    askQuestion()
  }

  func askQuestion(action: UIAlertAction! = nil) {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)

    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)

    title = "\(countries[correctAnswer].uppercased()) | Score: \(score)"
  }

  func resetGame(action: UIAlertAction) {
    questionsAnswered = 0
    score = 0
    askQuestion()
  }

  @IBAction func buttonTapped(_ sender: UIButton) {
    questionsAnswered += 1

    if sender.tag == correctAnswer {
      score += 1
    } else {
      let message = "Nope. That's the flag of \(countries[sender.tag].uppercased())"
      score -= 1

      let ac = UIAlertController(title: "Wrong", message: message, preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "Continue", style: .default))
      present(ac, animated: true)
    }

    if questionsAnswered >= 10 {
      let ac = UIAlertController(title: "Well done!", message: "Your score is \(score)", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: resetGame))
      present(ac, animated: true)
    } else {
      askQuestion()
    }
  }
}
