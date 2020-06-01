//
//  WhackSlot.swift
//  WhackAPenguin
//
//  Created by Vitali Tatarintev on 01.06.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
  var charNode: SKSpriteNode!

  func configure(at position: CGPoint) {
    self.position = position

    let sprite = SKSpriteNode(imageNamed: "whackHole")
    addChild(sprite)

    let cropNode = SKCropNode()
    cropNode.position = CGPoint(x: 0, y: 15)
    cropNode.zPosition = 1
    cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")

    charNode = SKSpriteNode(imageNamed: "penguinGood")
    charNode.position = CGPoint(x: 0, y: -90)
    charNode.name = "character"
    cropNode.addChild(charNode)

    addChild(cropNode)
  }
}
