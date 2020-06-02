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


  @IBAction func tapped(_ sender: UIButton) {
    sender.isHidden = true

    UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
      switch self.currentAnimation {
      case 0:
        self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        break
      case 1:
        self.imageView.transform = .identity // Resets back to original size/position
      case 2:
        self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
      case 3:
        self.imageView.transform = .identity
      default:
        break
      }
    }) { finished in
      sender.isHidden = false
    }

    currentAnimation += 1

    if currentAnimation > 7 {
      currentAnimation = 0
    }
  }
}

