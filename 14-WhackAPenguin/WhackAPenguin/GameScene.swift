//
//  GameScene.swift
//  WhackAPenguin
//
//  Created by Vitali Tatarintev on 01.06.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
  var gameScore: SKLabelNode!

  var score = 0 {
    didSet {
      gameScore.text = "Score: \(score)"
    }
  }

  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "whackBackground")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)

    gameScore = SKLabelNode(fontNamed: "Chalkduster")
    gameScore.text = "Score: 0"
    gameScore.position = CGPoint(x: 8, y: 8)
    gameScore.horizontalAlignmentMode = .left
    gameScore.fontSize = 48
    addChild(gameScore)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

  }
}
