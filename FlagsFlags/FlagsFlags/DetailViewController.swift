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

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionTapped))

    if let currentCountry = country {
      flagImage.image = UIImage(named: currentCountry)
      flagImage.layer.borderWidth = 1
      flagImage.layer.borderColor = UIColor.lightGray.cgColor
      
      title = currentCountry.uppercased()
    }
  }

  @objc func actionTapped() {
    guard let image = flagImage.image?.jpegData(compressionQuality: 0.8) else {
      print("No image")
      return
    }

    guard let currentCountry = country else { return }

    let vc = UIActivityViewController(activityItems: [image, currentCountry.uppercased()], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
  }

}
