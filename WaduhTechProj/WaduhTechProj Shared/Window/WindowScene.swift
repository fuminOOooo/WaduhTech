//
//  BlackboardScene.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 22/06/23.
//

import Foundation
import SpriteKit

class WindowScene {
    
    var spriteNode : SKSpriteNode!
    var timerWindow: SKLabelNode!
    var counter = 0
    var countdownTimer = Timer()
    var timeRemaining = 30
    
    // Audio Enable or Disable
    var soundEnabled: Bool = false

    var scene: SKScene!
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    let views: [SKTexture] = [SKTexture(imageNamed: "Untitled_Artwork 1"), SKTexture(imageNamed: "Untitled_Artwork"), SKTexture(imageNamed: "Untitled_Artwork 3")]
    
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
        timerWindow.text = "\(counter)"
        updateTextureIndex()
        updateAudioIndex()
    }
    
    func gameOver(won: Bool) {
        print("Game over with status: \(won)")
        
    }

    func updateTextureIndex() {
            
            if counter <= 10 {
                currentTextureIndex = 2
            } else if counter <= 20 {
                currentTextureIndex = 1
            } else if counter <= 30 {
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
            
            if counter == 10 || counter == 20 {
                let windowOpenSound = SKAction.playSoundFileNamed("soundWindow", waitForCompletion: false)
                scene.run(windowOpenSound)
            }
        }
    }
    
    func updateSpriteTexture() {
            let textureAction = SKAction.setTexture(views[currentTextureIndex])
            textureAction.speed = 0.5
            spriteNode.run(textureAction)
        }
    
}
