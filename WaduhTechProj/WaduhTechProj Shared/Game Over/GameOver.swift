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
    
    var mainMenuButton: SKSpriteNode!
    var startLocation: CGPoint? = nil

    public var win = true
    
    override func didMove(to view: SKView) {
        // Set up the scene
        let label = self.childNode(withName: "//gameOverLabel") as? SKLabelNode
        if win == false {
            label?.text = "You Failed!"
            let jumpscare = SKSpriteNode(imageNamed: "jumpscare")
            jumpscare.position = CGPoint(x: 0, y: 200)
            jumpscare.zPosition = 2
            jumpscare.size = CGSize(width: 600, height: 600)
            addChild(jumpscare)
        }
        mainMenuButton = SKSpriteNode(imageNamed: "mainMenuButton")
//        mainMenuButton.zPosition = 2
        mainMenuButton.position = CGPoint(x: 0, y: -200)
        mainMenuButton.size = CGSize(width: 500, height: 100)
        addChild(mainMenuButton)
        print("button loaded")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = MainMenu(fileNamed: "MainMenu")
        scene!.scaleMode = .aspectFit
        self.view?.presentScene(scene)
    }
    
}
