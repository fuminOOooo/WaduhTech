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
    
    var mainMenuButton: SKSpriteNode!
    var startLocation: CGPoint? = nil

    public var win = false
    
    override func didMove(to view: SKView) {
        // Set up the scene
        let label = self.childNode(withName: "//gameOverLabel") as? SKLabelNode
        if win == false {
            label?.text = "You Failed!"
            let jumpscare = SKSpriteNode(imageNamed: "jumpscare")
            jumpscare.position = CGPoint(x: frame.midX, y: frame.midY+100)
            jumpscare.zPosition = 2
            jumpscare.size = CGSize(width: 600, height: 600)
            addChild(jumpscare)
        }
        mainMenuButton = SKSpriteNode(imageNamed: "mainMenuButton")
        //        mainMenuButton.zPosition = 2
        mainMenuButton.position = CGPoint(x: frame.midX, y: frame.midY-300)
        mainMenuButton.size = CGSize(width: 500, height: 100)
        addChild(mainMenuButton)
        print("button loaded")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if mainMenuButton.contains(location) {
                print("button main menu clicked")
                startLocation = location
                let scene = MainMenu(fileNamed: "MainMenu")
                scene?.stage = stage
                scene!.scaleMode = .aspectFit
                self.view?.presentScene(scene)
            }
        }
    }
}
