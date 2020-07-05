//
//  ViewController.swift
//  SelfieShare
//
//  Created by Vitali Tatarintev on 05.07.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Selfie Share"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
  }

  @objc func importPicture() {
    
  }

}

