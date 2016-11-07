//
//  GameScene.swift
//  Whack-A-Penguin
//
//  Created by Mandy Cho on 7/7/16.
//  Copyright (c) 2016 Obsendian. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var slots = [WhackSlot]()
    var popupTime = 0.85
    var numRounds = 0
    
    var gameScore: SKLabelNode!
    var score: Int  = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .Left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        for i in 0..<5 {
            createSlotAt(CGPoint(x:(100 + i * 170), y: 410))
            createSlotAt(CGPoint(x:(100 + i * 170), y: 230))
        }
        
        for i in 0..<4 {
            createSlotAt(CGPoint(x:(180 + i * 170), y: 320))
            createSlotAt(CGPoint(x:(180 + i * 170), y: 140))
        }
        
        RunAfterDelay(1.0) { [unowned self] in
            self.numRounds += 1
            self.createEnemy()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)
            
            for node in nodes {
                if node.name == "good" {
                    let whackSlot = node.parent!.parent as! WhackSlot
                    
                    if !whackSlot.isVisible { continue }
                    if whackSlot.isHit { continue }
                    
                    whackSlot.hit()
                    
                    score -= 10
                    
                    runAction(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
                }
                else if node.name == "evil" {
                    let whackSlot = node.parent!.parent as! WhackSlot
                    if !whackSlot.isVisible { continue }
                    if whackSlot.isHit { continue }
                    
                    whackSlot.charNode.xScale = 0.85
                    whackSlot.charNode.yScale = 0.85
                    
                    whackSlot.hit()
                    
                    score += 5
                    
                    runAction(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func createSlotAt(pos: CGPoint){
        let slot = WhackSlot()
        slot.configureAtPosition(pos)
        addChild(slot)
        
        slots.append(slot)
    }
    
    func createEnemy(){
        if numRounds >= 30 {
            for slot in slots {
                slot.hide()
            }
            
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 2
            addChild(gameOver)
            
            return
        }
        
        popupTime *= 0.991
        
        slots = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(slots) as! [WhackSlot]
        slots[0].show(hideTime: popupTime)
        
        if RandomInt(min: 0, max: 12) > 4 { slots[1].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 8 { slots[2].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 10 { slots[3].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 11 { slots[4].show(hideTime: popupTime) }
        
        RunAfterDelay(RandomDouble(min: popupTime / 2, max: popupTime * 2)) { [unowned self] in
            self.numRounds += 1
            self.createEnemy()
        }
    }
}
