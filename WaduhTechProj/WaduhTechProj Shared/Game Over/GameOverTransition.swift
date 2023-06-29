//
//  GameOverTransition.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 29/06/23.
//

import Foundation
import SpriteKit

class GameOverTransition: SKScene {
    var stage: Int = 0
    var loseIndicator: Int = 0
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
        // MARK: To Define Gesture Available
        if (loseIndicator == 1) {
            loseFactor = "YOUR EXAM TIME HAS EXPIRED!"
        } else if (loseIndicator == 2) {
            loseFactor = "YOU WERE ATTACKED!"
        } else if (loseIndicator == 3) {
            loseFactor = "YOU FAILED TO ACHIEVE THE MINIMUM SCORE!"
        }
        
        loseLabel = SKLabelNode(attributedText: NSAttributedString(string: "\(loseFactor)",
                                                                       attributes: [.font: UIFont.systemFont(ofSize: 64, weight: .medium),
                                                                                    .foregroundColor: UIColor.red]))
        loseLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(loseLabel)
        
        mainMenuButton = SKSpriteNode(imageNamed: "mainMenuButton")
        mainMenuButton.position = CGPoint(x: frame.midX, y: frame.midY-200)
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
                let scene = MainMenu(fileNamed: "MainMenu")!
                scene.stage = 0
                scene.scaleMode = .aspectFit
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
}
