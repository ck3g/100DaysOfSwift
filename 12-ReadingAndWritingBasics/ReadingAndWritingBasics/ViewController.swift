//
//  ViewController.swift
//  ReadingAndWritingBasics
//
//  Created by Vitali Tatarintev on 04.05.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let defaults = UserDefaults.standard

    defaults.set(25, forKey: "Age")
    defaults.set(true, forKey: "UserFaceID")
    defaults.set(CGFloat.pi, forKey: "Pi")
    defaults.set("Vitali", forKey: "name")
    defaults.set(Date(), forKey: "LastRun")

    let array = ["Hello", "world"]
    defaults.set(array, forKey: "SavedArray")

    let dict = ["Name": "Vitali", "Country": "Germany"]
    defaults.set(dict, forKey: "SavedDictionary")
  }


}

