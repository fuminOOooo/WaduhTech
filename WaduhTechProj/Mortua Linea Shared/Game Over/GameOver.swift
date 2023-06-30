//
//  GameOver.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 23/06/23.
//

import Foundation
import SpriteKit
import GameplayKit

class GameOver: SKScene {
    
    var stage: Int = 0
    var loseIndicator: Int = 0
    
    var timer = Timer()
    let transition = SKTransition.fade(with: .red, duration: 3)
    
    override func didMove(to view: SKView) {
        // Set up the scene
        let jumpscare = SKSpriteNode(imageNamed: "jumpscare")
        jumpscare.position = CGPoint(x: frame.midX, y: frame.midY)
        jumpscare.zPosition = 2
        jumpscare.size = CGSize(width: frame.width, height: frame.height)
        addChild(jumpscare)
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToTransition), userInfo: nil, repeats: false)

        let jumpscareSound = SKAction.playSoundFileNamed("jumpscareFix", waitForCompletion: false)
        self.run(jumpscareSound)
        
        print(loseIndicator)
    }
    
    @objc func moveToTransition() {
        //Configure the new scene to be presented and then present.
        let scene = GameOverTransition()
        scene.stage = stage
        scene.loseIndicator = loseIndicator
        scene.size = CGSize(width: frame.width, height: frame.height)
        self.view?.presentScene(scene, transition: transition)
        
    }
}
