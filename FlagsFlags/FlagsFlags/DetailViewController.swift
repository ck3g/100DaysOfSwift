//
//  DetailViewController.swift
//  FlagsFlags
//
//  Created by Vitali Tatarintev on 05.03.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet var flagImage: UIImageView!

  var country: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    if let currentCountry = country {
      flagImage.image = UIImage(named: currentCountry)
      flagImage.layer.borderWidth = 1
      flagImage.layer.borderColor = UIColor.lightGray.cgColor
      
      title = currentCountry.uppercased()
    }
  }

}
