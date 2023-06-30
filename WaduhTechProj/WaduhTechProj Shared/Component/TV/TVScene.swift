//
//  TVScene.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 28/06/23.
//

import Foundation
import SpriteKit

class TVScene {
    var spriteNode : SKSpriteNode!
    var timerTV: SKLabelNode!
    var holdTimer : Timer?
    var spriteLocation : SKView?
    var touchStartTime: TimeInterval = 0.0
    var countdownTimer: Timer?
    
    // Audio Enable or Disable
    var soundEnabled: Bool = false
    var tvSound: SKAction!
    var tvSound2: SKAction!
    
    var scene: SKScene!
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    let views: [SKTexture] = [SKTexture(imageNamed: "tv_1"), SKTexture(imageNamed: "tv_2"), SKTexture(imageNamed: "tv_3"), SKTexture(imageNamed: "tv_4")]
    
    var timeRemaining: TimeInterval = 40.0 {
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
        
        if timeRemaining <= 10 {
            currentTextureIndex = 3
        } else if timeRemaining <= 20 {
            currentTextureIndex = 2
        } else if timeRemaining <= 30 {
            currentTextureIndex = 1
        } else if timeRemaining <= 40 {
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
            
            if timeRemaining == 30 || timeRemaining == 20 {
                tvSound = SKAction.playSoundFileNamed("television_1", waitForCompletion: false)
                let playSoundAction = SKAction.group([tvSound])
                scene.run(tvSound, withKey: "tvSound")
            }
            else if timeRemaining == 10 {
                tvSound2 = SKAction.playSoundFileNamed("television_3", waitForCompletion: false)
                let playSoundAction = SKAction.group([tvSound2])
                scene.run(tvSound2, withKey: "tvSound2")
            }
            else if timeRemaining >= 31 {
                spriteNode.removeAction(forKey: "tvSound")
                spriteNode.removeAction(forKey: "tvSound2")
            }
        }
        else if !soundEnabled {
            spriteNode.removeAction(forKey: "tvSound")
            spriteNode.removeAction(forKey: "tvSound2")

        }
    }
}

