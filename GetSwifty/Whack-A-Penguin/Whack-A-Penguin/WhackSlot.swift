//
//  WhackSlot.swift
//  Whack-A-Penguin
//
//  Created by Mandy Cho on 7/11/16.
//  Copyright © 2016 Obsendian. All rights reserved.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
    var charNode: SKSpriteNode!
    
    var isVisible = false
    var isHit = false

    
    func configureAtPosition(pos: CGPoint){
        position = pos
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        // crop is a sibling of the whackHole object
        let crop = SKCropNode()
        crop.position = CGPoint(x: 0, y: 15)
        crop.zPosition = 1
        crop.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        // Creat a charNode child object of crop
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        crop.addChild(charNode)
        
        addChild(crop)
    }
    
    func hit(){
        let wait = SKAction.waitForDuration(0.25)
        let hide = SKAction.moveByX(0, y: -80, duration: 0.5)
        let visibility = SKAction.runBlock { [unowned self] in self.isVisible = false }
        charNode.runAction(SKAction.sequence([wait, hide, visibility]))
    }
    
    func show(hideTime hideTime: Double){
        if isVisible {
            return
        }
        // Make penguin visible
        charNode.yScale = 1
        charNode.xScale = 1
        
        charNode.runAction(SKAction.moveByX(0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        // Determine identity
        if RandomInt(min: 0, max: 2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "good"
        }
        else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "evil"
        }
        
        RunAfterDelay(hideTime * 3.5) { [unowned self] in
            self.hide()
        }
    }
    
    func hide(){
        if !isVisible {
            return
        }
        charNode.runAction(SKAction.moveByX(0, y: -80, duration: 0.05))
        isVisible = false
    }
}
