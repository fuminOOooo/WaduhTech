//
//  GameCredits.swift
//  WaduhTechProj iOS
//
//  Created by Elvis Susanto on 30/06/23.
//

import Foundation
import SpriteKit

class GameCredits: SKScene {
    
    var mainMenuButton: SKSpriteNode!
    var startLocation: CGPoint? = nil
    var loseLabel: SKLabelNode!
    var loseFactor = ""
    // 1 = Ran out of global timer
    // 2 = Failed to maintain obstacle
    // 3 = Failed to reach minimum score
    
    let transition = SKTransition.fade(with: .black, duration: 3)

    
    override func didMove(to view: SKView) {
        scene?.backgroundColor = .black
        loseFactor = "\"We Did it!\""

        loseLabel = SKLabelNode(attributedText: NSAttributedString(string: "\(loseFactor)", attributes: [.font: UIFont(name: "hulberthopperdisplay", size: 64)!, .foregroundColor: UIColor.white]))
        loseLabel.position = CGPoint(x: frame.midX, y: frame.midY+100)
        addChild(loseLabel)
        
        loseFactor = "Thank You for Playing!"
        loseLabel = SKLabelNode(attributedText: NSAttributedString(string: "\(loseFactor)", attributes: [.font: UIFont(name: "hulberthopperdisplay", size: 64)!, .foregroundColor: UIColor.white]))
        loseLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(loseLabel)
        
        mainMenuButton = SKSpriteNode(imageNamed: "menuButton")
        mainMenuButton.position = CGPoint(x: frame.midX, y: frame.midY-200)
        mainMenuButton.size = CGSize(width: 485, height: 100)
        addChild(mainMenuButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if mainMenuButton.contains(location) {
                startLocation = location
                let scene = MainMenu(fileNamed: "MainMenu")!
                scene.stage = 4
                scene.scaleMode = .aspectFit
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
}


