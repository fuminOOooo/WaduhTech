//
//  DrawerScene.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 22/06/23.
//

import Foundation
import SpriteKit

class DrawerScene : SKScene {
    
    var spriteNode : SKSpriteNode!
    var timerDrawer: SKLabelNode!
    var counter = 0
    var countdownTimer = Timer()
    var countdownStart = 12
    
    let views: [SKTexture] = [SKTexture(imageNamed: "drawerClosed"), SKTexture(imageNamed: "drawerOpen")]
    
    var currentTextureIndex: Int = 0 {
        didSet {
            updateSpriteTexture()
        }
    }
    
    func startCountdown() {
        counter = countdownStart // Set counter to countdownStart
        countdownTimer.invalidate() // Invalidate the previous timer if it exists
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func decrementCounter() {
        counter -= 1
        timerDrawer.text = "\(counter)"
        updateTextureIndex()
    }
    
    func updateTextureIndex() {
        
        if counter <= 5 {
            currentTextureIndex = 1
        } else if counter <= 10 {
            currentTextureIndex = 0
        }
        
    }
    
    func updateSpriteTexture() {
        let textureAction = SKAction.setTexture(views[currentTextureIndex])
        textureAction.speed = 0.5
        spriteNode.run(textureAction)
    }
}
