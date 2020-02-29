//
//  DetailViewController.swift
//  Project1
//
//  Created by Vitali Tatarintev on 29.02.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet var imageView: UIImageView!

  var selectedImage: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    title = selectedImage

    if let imageToLoad = selectedImage {
      imageView.image = UIImage(named: imageToLoad)
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }

}
