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
  func configure(at position: CGPoint) {
    self.position = position

    let sprite = SKSpriteNode(imageNamed: "whackHole")
    addChild(sprite)
  }
}
