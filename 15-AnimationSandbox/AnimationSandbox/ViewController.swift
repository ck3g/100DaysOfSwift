//
//  ViewController.swift
//  AnimationSandbox
//
//  Created by Vitali Tatarintev on 02.06.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var imageView: UIImageView!
  var currentAnimation = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    imageView = UIImageView(image: UIImage(named: "penguin"))
    imageView.center = CGPoint(x: 512, y: 384)
    view.addSubview(imageView)
  }


  @IBAction func tapped(_ sender: Any) {
    currentAnimation += 1

    if currentAnimation > 7 {
      currentAnimation = 0
    }
  }
}

