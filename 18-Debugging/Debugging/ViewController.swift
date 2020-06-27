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

    // The second debugging technique is using `assert` which will crash if the condition is not true
    assert(1 == 1, "Math failure!")
    // assert(1 == 2, "Math failure!") // uncomment to see the failure
    // assert(myReallySlowMethdod() == true, "The slow method returned false, which is a bad thing.")


    // Debugging using breakpoints
    for i in 1...100 {
      print("Got number \(i).")

      // Click on the line number to set the breakpoint
      // Click and drag the breakout out, to remove it

      // You can set condition for breakpoint. Right clikc on the breakpoint and choose "Edit breakpoint..."
    }
  }



}

