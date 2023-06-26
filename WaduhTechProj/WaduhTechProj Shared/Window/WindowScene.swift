//
//  WindowScene.swift
//  TestTestMC2
//
//  Created by Elvis Susanto on 21/06/23.
//

import SpriteKit

class WindowScene {
    
    var spriteNode : SKSpriteNode!
    var timerLabel: SKLabelNode!
    var holdTimer : Timer?
    var spriteLocation : SKView?
    var touchStartTime: TimeInterval = 0.0
    var countdownTimer: Timer?
    
    var scene: SKScene!
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    let views: [SKTexture] = [SKTexture(imageNamed: "Untitled_Artwork 1"), SKTexture(imageNamed: "Untitled_Artwork"), SKTexture(imageNamed: "Untitled_Artwork 3")]
    
    var timeRemaining: TimeInterval = 12.0 {
        didSet {
            updateTimerLabel()
            updateColorIndex()
        }
    }

    var currentColorIndex: Int = 0 {
        didSet {
            updateSpriteColor()
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
        timerLabel.text = "\(Int(timeRemaining))"
    }

    func updateColorIndex() {
        
        if timeRemaining <= 3 {
            currentColorIndex = 2
        } else if timeRemaining <= 6 {
            currentColorIndex = 1
        } else if timeRemaining <= 9 {
            currentColorIndex = 0
        }

    }

    func updateSpriteColor() {
        let colorAction = SKAction.setTexture(views[currentColorIndex])
        colorAction.speed = 0.5
        spriteNode.run(colorAction)
    }

}
