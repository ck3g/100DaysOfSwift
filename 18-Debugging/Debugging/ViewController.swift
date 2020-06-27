//
//  ViewController.swift
//  Debugging
//
//  Created by Vitali Tatarintev on 27.06.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // The first technique is debugging with `print` function.
    print("I'm inside the viewDidLoad() method.")

    print("You can print any number of parameters", 1, 2, 3, 4, 5, true, separator: " - ")
    print("Some message with a terminator", terminator: "\n> tadam tam tadam... tadam tam tadam... tadatam taa-daa-taam")
  }


}

