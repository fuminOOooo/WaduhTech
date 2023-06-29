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
    
    var scene: SKScene!
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    let views: [SKTexture] = [SKTexture(imageNamed: "Untitled_Artwork 1"), SKTexture(imageNamed: "Untitled_Artwork"), SKTexture(imageNamed: "Untitled_Artwork 3")]
    
    var timeRemaining: TimeInterval = 32.0 {
        didSet {
            updateTimerLabel()
            updateTextureIndex()
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
    
    func updateTimerLabel() {
        timerTV.text = "\(Int(timeRemaining))"
    }
    
    func updateTextureIndex() {
        
        if timeRemaining <= 10 {
            currentTextureIndex = 2
        } else if timeRemaining <= 20 {
            currentTextureIndex = 1
        } else if timeRemaining <= 30 {
            currentTextureIndex = 0
        }
    }
        
        func updateSpriteTexture() {
            let colorAction = SKAction.setTexture(views[currentTextureIndex])
            colorAction.speed = 0.5
            spriteNode.run(colorAction)
        }
        
    }

