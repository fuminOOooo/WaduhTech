//
//  LeftChairScene.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 30/06/23.
//

import Foundation
import SpriteKit

class LeftChairScene {
    
    var spriteNode: SKSpriteNode!
    var timerLChair: SKLabelNode!
    var counter = 0
    var countdownTimer = Timer()
    var timeRemaining = 26
    
    // Audio Enable or Disable
    var soundEnabled: Bool = false
    
    var scene: SKScene!
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    let views: [SKTexture] = [SKTexture(imageNamed: "kursiTap1_1"), SKTexture(imageNamed: "kursiTap1_2")]
    
    var currentTextureIndex: Int = 0 {
        didSet {
            updateSpriteTexture()
        }
    }
    
    func startCountdown() {
        counter = timeRemaining // Set counter to countdownStart
        countdownTimer.invalidate() // Invalidate the previous timer if it exists
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc func decrementCounter() {
        
        counter -= 1
        counter = max(counter, 0)
        updateTextureIndex()
        updateAudioIndex()
    }
    
    func updateTextureIndex() {
        
        if counter <= 13 {
            currentTextureIndex = 1
        } else if counter <= 26 {
            currentTextureIndex = 0
        }
    }
    
    func enableSoundEffects() {
        soundEnabled = true
    }
    
    func disableSoundEffects() {
        soundEnabled = false
    }
    
    func updateAudioIndex() {
        if soundEnabled {
            
            if counter == 10 {
                let cupboardOpenSound = SKAction.playSoundFileNamed("kursiTap1_1", waitForCompletion: false)
                scene.run(cupboardOpenSound)
            }
        }
    }
    
    func updateSpriteTexture() {
        let textureAction = SKAction.setTexture(views[currentTextureIndex])
        textureAction.speed = 0.5
        spriteNode.run(textureAction)
    }}
