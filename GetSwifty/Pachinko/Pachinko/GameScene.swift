//
//  GameScene.swift
//  Pachinko
//
//  Created by Mandy Cho on 6/27/16.
//  Copyright (c) 2016 Obsendian. All rights reserved.
//



// TODO: RANDOMIZATION OF BOX LOCATIONS; SPECIAL BALLS THAT GIVE EXTRA TRIES, ability to replay when all balls are gone;


import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let colorArray = ["Blue", "Cyan", "Green", "Purple", "Red", "Yellow"]

    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var ballLabel: SKLabelNode!
    var ballCount: Int = 5 {
        didSet {
            ballLabel.text = "Balls: \(ballCount)"
        }
    }
    
    var editLabel: SKLabelNode!
    var editingMode: Bool = false {
        didSet{
            if editingMode {
                editLabel.text = "Done"
            }
            else {
                editLabel.text = "Edit"
            }
        }
    }
    
    var randomLabel = SKLabelNode(fontNamed: "Chalkduster")
    // TODO: Create randomly
    
    
    override func didMoveToView(view: SKView) {
        // Background UI
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        physicsWorld.contactDelegate = self
        
        // Score Label
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .Right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        // Ball Label
        ballLabel = SKLabelNode(fontNamed: "ChalkDuster")
        ballLabel.text = "Balls: 5"
        ballLabel.horizontalAlignmentMode = .Right
        ballLabel.position = CGPoint(x: scoreLabel.position.x, y: (scoreLabel.position.y - 40))
        addChild(ballLabel)
        
        
        // Edit Label
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        // Random Label
        randomLabel.text = "Random"
        randomLabel.position = CGPoint(x: (frame.width / 2), y: 700)
        addChild(randomLabel)
        
        
        // Slot index
        var j = 1
        
        for i in 0...4 {
            makeBouncerAt(CGPoint(x:(i * 256), y: 0))
            
            if i % 2 == 1 {
                makeSlotAt(CGPoint(x: (j * 128), y: 0), isGood: true)
                j += 2
            }
            // No need to create a slot at (0,0), but necessary for even values
            else if i != 0 {
                makeSlotAt(CGPoint(x: (j * 128), y: 0), isGood: false)
                j += 2
            }
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            let location = touch.locationInNode(self)
            
            let objects = nodesAtPoint(location) as [SKNode]
            
            if objects.contains(editLabel) {
               editingMode = !editingMode
            }
            else {
                if editingMode{
                    let size = CGSize(width: GKRandomDistribution(lowestValue: 16, highestValue:128).nextInt(), height: 16)
                    let box = SKSpriteNode(color: RandomColor(), size: size)
                    box.zRotation = RandomCGFloat(min: 0, max: 3)
                    box.position = location
                    box.name = "obstacle"
                    
                    box.physicsBody = SKPhysicsBody(rectangleOfSize: box.size)
                    box.physicsBody!.dynamic = false
                    
                    addChild(box)
                }
                else if !editingMode && ballCount != 0{
                    let randomIndex = Int(arc4random_uniform(UInt32(colorArray.count)))
                    let ball = SKSpriteNode(imageNamed: "ball\(colorArray[randomIndex])")
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                    ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                    ball.physicsBody!.restitution = 0.4
                    ball.position = CGPoint(x: location.x, y: frame.height)
                    ball.name = "ball"
                    ball.zPosition = 1.0
                    ballCount -= 1
                    
                    addChild(ball)
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    /// Spawns bouncer at the specified coordinate
    ///  - Parameters:
    ///     - position: (x,y) location to create bouncer object
    func makeBouncerAt(position: CGPoint){
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody!.contactTestBitMask = bouncer.physicsBody!.collisionBitMask
        bouncer.physicsBody!.dynamic = false
        bouncer.zPosition = 1.0
        addChild(bouncer)
    }
    
    /// Spawns slots and glow effects at the specified coorinate
    /// - Parameters:
    ///     - position: (x,y) location to create slot and glow objects
    ///     - isGood: Boolean value to denote if good or bad slot
    func makeSlotAt(position: CGPoint, isGood: Bool){
        
        var slot: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slot = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slot.name = "good"
        }
        else {
            slot = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slot.name = "bad"
        }
        
        slot.position = position
        slotGlow.position = position
        
        let spin = SKAction.rotateByAngle(CGFloat(M_PI_2), duration: 10) // 90 degree rotation
        let spinForever = SKAction.repeatActionForever(spin)
        slotGlow.runAction(spinForever)
        
        slot.physicsBody = SKPhysicsBody(rectangleOfSize: slot.size)
        slot.physicsBody!.dynamic = false
        
        addChild(slot)
        addChild(slotGlow)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        // Ball hits Slot
        if contact.bodyA.node!.name == "ball" {
            collisionBetweenObjects(contact.bodyA.node!, object: contact.bodyB.node!)
        }
        // Slot hits ball
        else if contact.bodyB.node!.name == "ball"{
            collisionBetweenObjects(contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    /// Alters score depending on where the ball collides
    /// - Parameters:
    ///     - ball: balll object that collides with slot
    ///     - object: the slot in which the ball came in contact with
    func collisionBetweenObjects(ball: SKNode, object: SKNode){
        if object.name == "good" {
            destroyObject(ball)
            score += 10
        }
        else if object.name == "bad"{
            destroyObject(ball)
            score -= 10
        }
        else if object.name == "obstacle" {
            destroyObject(object)
        }
    }
    
    func destroyObject(object: SKNode){
        if object.name == "ball" {
            if let fire = SKEmitterNode(fileNamed: "FireParticles"){
                fire.position = object.position
                fire.zPosition = 2.0
                addChild(fire)
            }
        }
        
        object.removeFromParent()
    }
    
    
    
}
