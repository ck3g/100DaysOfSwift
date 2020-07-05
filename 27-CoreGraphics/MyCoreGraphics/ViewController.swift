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
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

    let image = renderer.image { ctx in
      let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)

      ctx.cgContext.setFillColor(UIColor.red.cgColor)
      ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
      ctx.cgContext.setLineWidth(10)

      ctx.cgContext.addRect(rectangle)
      ctx.cgContext.drawPath(using: .fillStroke)
    }

    imageView.image = image
  }

}

