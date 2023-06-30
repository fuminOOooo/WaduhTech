//
//  TVScene.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 28/06/23.
//

import Foundation
import SpriteKit
import AVFoundation

class TVScene {
    var spriteNode : SKSpriteNode!
    var timerTV: SKLabelNode!
    var holdTimer : Timer?
    var spriteLocation : SKView?
    var touchStartTime: TimeInterval = 0.0
    var countdownTimer: Timer?
    
    // Audio Enable or Disable
    var soundEnabled: Bool = false
    var audioPlayer: AVAudioPlayer!
    
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
    
    func tvSound1() {
        let path = Bundle.main.path(forResource: "television_1", ofType: "wav")
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
    
    func tvSound2() {
        let path = Bundle.main.path(forResource: "television_3", ofType: "wav")
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
    
    func updateAudioIndex() {
        if soundEnabled {
            
            if timeRemaining == 30 || timeRemaining == 20 {
                
            }
            else if timeRemaining == 10 {
                
            }
        }
    }
}

