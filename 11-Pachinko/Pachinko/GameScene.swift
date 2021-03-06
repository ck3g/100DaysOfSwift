//
//  GameScene.swift
//  Pachinko
//
//  Created by Vitali Tatarintev on 30.04.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  let balls = ["ballBlue", "ballCyan", "ballGreen", "ballGrey", "ballPurple", "ballRed", "ballYellow"]
  let ballYStartPosition: CGFloat = 700
  let maxBalls = 5

  var scoreLabel: SKLabelNode!

  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }

  var editLabel: SKLabelNode!

  var editingMode: Bool = false {
    didSet {
      if editingMode {
        editLabel.text = "Done"
      } else {
        editLabel.text = "Edit"
        score = 0
        ballsLeft = maxBalls
      }
    }
  }

  var ballsLabel: SKLabelNode!

  var ballsLeft = 5 {
    didSet {
      ballsLabel.text = "Balls: \(ballsLeft)"
    }
  }
  
  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace // renders faster
    background.zPosition = -1
    addChild(background)

    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.text = "Score: 0"
    scoreLabel.horizontalAlignmentMode = .right
    scoreLabel.position = CGPoint(x: 980, y: 700)
    addChild(scoreLabel)

    ballsLabel = SKLabelNode(fontNamed: "Chalkduster")
    ballsLabel.text = "Balls: \(maxBalls)"
    ballsLabel.horizontalAlignmentMode = .right
    ballsLabel.position = CGPoint(x: 980, y: 660)
    addChild(ballsLabel)

    editLabel = SKLabelNode(fontNamed: "Chalkduster")
    editLabel.text = "Edit"
    editLabel.position = CGPoint(x: 80, y: 700)
    addChild(editLabel)

    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    physicsWorld.contactDelegate = self


    makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
    makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
    makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
    makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)

    makeBouncer(at: CGPoint(x: 0, y: 0))
    makeBouncer(at: CGPoint(x: 256, y: 0))
    makeBouncer(at: CGPoint(x: 512, y: 0))
    makeBouncer(at: CGPoint(x: 768, y: 0))
    makeBouncer(at: CGPoint(x: 1024, y: 0))

  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)

    let objects = nodes(at: location)

    if objects.contains(editLabel) {
      editingMode.toggle()
    } else {
      if editingMode {
        makeObstacle(at: location)
      } else {
        if ballsLeft > 0 {
          makeBall(at: location)
          ballsLeft -= 1
        }
      }
    }
  }

  func makeObstacle(at location: CGPoint) {
    // create a box
    let size = CGSize(width: Int.random(in: 16...128), height: 16)
    let boxColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
    let box = SKSpriteNode(color: boxColor, size: size)
    box.zRotation = CGFloat.random(in: 0...3)
    box.position = location

    box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
    box.physicsBody?.isDynamic = false
    box.name = "obstacle"
    addChild(box)
  }

  func makeBall(at location: CGPoint) {
    let ball = SKSpriteNode(imageNamed: balls.shuffled()[0])
    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
    ball.physicsBody?.restitution = 0.4
    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
    ball.position = CGPoint(x: location.x, y: ballYStartPosition)
    ball.name = "ball"
    addChild(ball)
  }

  func makeBouncer(at position: CGPoint) {
    let bouncer = SKSpriteNode(imageNamed: "bouncer")
    bouncer.position = position
    bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
    bouncer.physicsBody?.isDynamic = false
    addChild(bouncer)
  }

  func makeSlot(at position: CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode
    var slotGlow: SKSpriteNode

    if isGood {
      slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
      slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
      slotBase.name = "good"
    } else {
      slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
      slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
      slotBase.name = "bad"
    }

    slotBase.position = position
    slotGlow.position = position

    slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
    slotBase.physicsBody?.isDynamic = false

    addChild(slotBase)
    addChild(slotGlow)

    let spin = SKAction.rotate(byAngle: .pi, duration: 10)
    let spinForever = SKAction.repeatForever(spin)
    slotGlow.run(spinForever)
  }

  func collision(between ball: SKNode, object: SKNode) {
    if object.name == "good" {
      destroy(ball: ball)
      score += 1
      ballsLeft += 1
    } else if object.name == "bad" {
      destroy(ball: ball)
      score -= 1
    } else if object.name == "obstacle" {
      object.removeFromParent()
    }
  }

  func destroy(ball: SKNode) {
    if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
      fireParticles.position = ball.position
      addChild(fireParticles)
    }
    
    ball.removeFromParent()
  }

  func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }

    if nodeA.name == "ball" {
      collision(between: nodeA, object: nodeB)
    } else if nodeB.name == "ball" {
      collision(between: nodeB, object: nodeA)
    }
  }

}
