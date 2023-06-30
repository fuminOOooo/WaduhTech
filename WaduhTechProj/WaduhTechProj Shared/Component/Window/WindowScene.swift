//
//  BlackboardScene.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 22/06/23.
//

import Foundation
import SpriteKit
import AVFoundation

class WindowScene {
    
    var spriteNode : SKSpriteNode!
    var timerWindow: SKLabelNode!
    var counter = 0
    var countdownTimer = Timer()
    var timeRemaining = 21
    var audioPlayer: AVAudioPlayer! // Add this line
    
    // Audio Enable or Disable
    var soundEnabled: Bool = false
    
    var scene: SKScene!
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    let views: [SKTexture] = [SKTexture(imageNamed: "windowState1"), SKTexture(imageNamed: "windowState2"), SKTexture(imageNamed: "windowState3")]
    
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
        
        if counter <= 7 {
            currentTextureIndex = 2
        } else if counter <= 14 {
            currentTextureIndex = 1
        } else if counter <= 21 {
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
            if counter == 7 {
                let windowOpenSound = SKAction.playSoundFileNamed("window3_openclose", waitForCompletion: false)
                scene.run(windowOpenSound)
            }
            else if counter == 14 {
                let window2OpenSound = SKAction.playSoundFileNamed("window2_openclose", waitForCompletion: false)
                scene.run(window2OpenSound)
                outsideSound() // Start playing the "window_outside" audio
            } else if counter == 21 {
                audioPlayer?.stop() // Stop playing the "window_outside" audio
            }
        }
    }
    
    func outsideSound() {
        let path = Bundle.main.path(forResource: "window_outside", ofType: "wav")
        let fileURL = URL(fileURLWithPath: path!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
        } catch {
            print("error play music")
        }
        audioPlayer.numberOfLoops = -1 //Infinite
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func updateSpriteTexture() {
        let textureAction = SKAction.setTexture(views[currentTextureIndex])
        textureAction.speed = 0.5
        spriteNode.run(textureAction)
    }
    
}
