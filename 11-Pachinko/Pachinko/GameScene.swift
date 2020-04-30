//
//  GameScene.swift
//  Pachinko
//
//  Created by Vitali Tatarintev on 30.04.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: 512, y: 384)
    addChild(background)
  }
  
}
