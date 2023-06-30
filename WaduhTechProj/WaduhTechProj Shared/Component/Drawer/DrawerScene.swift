//
//  LaciScene.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 28/06/23.
//

import Foundation
import SpriteKit

class DrawerScene {    
    var spriteNode : SKSpriteNode!
    var timerLaci: SKLabelNode!
    var holdTimer : Timer?
    var spriteLocation : SKView?
    var touchStartTime: TimeInterval = 0.0
    var countdownTimer: Timer?
    
    // Audio Enable or Disable
    var soundEnabled: Bool = false
    
    var scene: SKScene!
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    let views: [SKTexture] = [SKTexture(imageNamed: "drawer_1"), SKTexture(imageNamed: "drawer_2"), SKTexture(imageNamed: "drawer_3"), SKTexture(imageNamed: "drawer_4")]
    
    var timeRemaining: TimeInterval = 32.0 {
        didSet {
            updateTextureIndex()
            updateAudioIndex()
        }
    }
    
    var currentTextureIndex: Int = 0 {
        didSet {
            updateSpriteTexture()
        }
    }
    
    func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1.0
            }
        }
    }
    
    func updateTextureIndex() {
        
        if timeRemaining <= 8 {
            currentTextureIndex = 3
        } else if timeRemaining <= 16 {
            currentTextureIndex = 2
        } else if timeRemaining <= 24 {
            currentTextureIndex = 1
        } else if timeRemaining <= 32 {
            currentTextureIndex = 0
        }
    }
    
    func updateSpriteTexture() {
        let colorAction = SKAction.setTexture(views[currentTextureIndex])
        colorAction.speed = 0.5
        spriteNode.run(colorAction)
    }
    
    func enableSoundEffects() {
        soundEnabled = true
    }
    
    func disableSoundEffects() {
        soundEnabled = false
    }
    
    func updateAudioIndex() {
        if soundEnabled {
            
            if timeRemaining == 24 || timeRemaining == 16 || timeRemaining == 8 {
                let drawerSound = SKAction.playSoundFileNamed("drawer_1", waitForCompletion: false)
                scene.run(drawerSound)
            }
        }
    }
    
}
