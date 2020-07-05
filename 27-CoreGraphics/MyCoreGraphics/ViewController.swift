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
    case 1:
      drawCircle()
    case 2:
      drawCheckerboard()
    case 3:
      drawRotatedSquares()
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

  func drawCircle() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

    let image = renderer.image { ctx in
      let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)

      ctx.cgContext.setFillColor(UIColor.red.cgColor)
      ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
      ctx.cgContext.setLineWidth(10)

      ctx.cgContext.addEllipse(in: rectangle)
      ctx.cgContext.drawPath(using: .fillStroke)
    }

    imageView.image = image
  }

  func drawCheckerboard() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

    let image = renderer.image { ctx in
      ctx.cgContext.setFillColor(UIColor.black.cgColor)

      for row in 0 ..< 8 {
        for col in 0 ..< 8 {
          // if (row + col) % 2 == 0 {
          if (row + col).isMultiple(of: 2) {
            ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
          }
        }
      }
    }

    imageView.image = image
  }

  func drawRotatedSquares() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

    let image = renderer.image { ctx in
      ctx.cgContext.translateBy(x: 256, y: 256)

      let rotations = 16
      let amount = Double.pi / Double(rotations)

      for _ in 0 ..< rotations {
        ctx.cgContext.rotate(by: CGFloat(amount))
        ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
      }

      ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
      ctx.cgContext.strokePath()
    }

    imageView.image = image
  }

}

