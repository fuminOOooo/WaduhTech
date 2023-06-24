//
//  DrawerScene.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 22/06/23.
//

import SwiftUI
import SpriteKit

class DrawerScene {
    
    var spriteNode : SKSpriteNode!
    var timerDrawer: SKLabelNode!
    var counter = 0
    var countdownTimer = Timer()
    var timeRemaining = 15
    
    var scene: SKScene!
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    let views: [SKTexture] = [SKTexture(imageNamed: "closedCupboard"), SKTexture(imageNamed: "openedCupboard")]
    
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
        
        if counter < 1 {
            gameOver(won: false)
        }
        
        counter -= 1
        counter = max(counter, 0)
        timerDrawer.text = "\(counter)"
        updateTextureIndex()
        updateAudioIndex()
    }
    
    func gameOver(won: Bool) {
        print("Game over with status: \(won)")
        
    }
    
    func updateTextureIndex() {
        
        if counter <= 10 {
            currentTextureIndex = 1
        } else if counter <= 15 {
            currentTextureIndex = 0
        }
    }
    
    func updateAudioIndex() {
        if counter == 10 {
            let cupboardOpenSound = SKAction.playSoundFileNamed("cupboardOpening", waitForCompletion: false)
            scene.run(cupboardOpenSound)
        }
    }
    
    func updateSpriteTexture() {
        let textureAction = SKAction.setTexture(views[currentTextureIndex])
        textureAction.speed = 0.5
        spriteNode.run(textureAction)
    }
}
