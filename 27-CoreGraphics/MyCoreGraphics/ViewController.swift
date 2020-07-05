//
//  ViewController.swift
//  CoreGraphics
//
//  Created by Vitali Tatarintev on 05.07.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var imageView: UIImageView!
  var currentDrawType = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    drawRectangle()
  }

  @IBAction func redrawTapped(_ sender: Any) {
    currentDrawType += 1

    if currentDrawType > 5 {
      currentDrawType = 0
    }

    switch currentDrawType {
    case 0:
      drawRectangle()
    default:
      break
    }
  }

  func drawRectangle() {

  }

}

