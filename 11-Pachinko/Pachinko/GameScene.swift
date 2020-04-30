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
    background.blendMode = .replace // renders faster
    background.zPosition = -1
    addChild(background)

    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)

    let ball = SKSpriteNode(imageNamed: "ballRed")
    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
    ball.physicsBody?.restitution = 0.4
    ball.position = location
    addChild(ball)
  }
  
}
