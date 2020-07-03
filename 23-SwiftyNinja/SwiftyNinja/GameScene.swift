//
//  GameScene.swift
//  SwiftyNinja
//
//  Created by Vitali Tatarintev on 03.07.20.
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

  var liveImages = [SKSpriteNode]()
  var lives = 3

  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "sliceBackground")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)

    physicsWorld.gravity = CGVector(dx: 0, dy: -6)
    physicsWorld.speed = 0.85

    createScore()
    createLives()
    createSlices()
  }

  func createScore() {

  }

  func createLives() {

  }

  func createSlices() {

  }

}
