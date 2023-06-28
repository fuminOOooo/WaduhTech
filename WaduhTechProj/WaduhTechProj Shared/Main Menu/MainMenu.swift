//
//  MainMenu.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 25/06/23.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {
    
    var stage: Int = 0
    
    var newGame: SKSpriteNode!
    var continueButton: SKSpriteNode!
    var startLocation: CGPoint? = nil
    
    override func didMove(to view: SKView) {
        
        // MARK: Button New Game
        newGame = SKSpriteNode(imageNamed: "newGameButton")
        newGame.zPosition = 2
        newGame.position = CGPoint(x: 0, y: -100)
        newGame.size = CGSize(width: 500, height: 100)
        addChild(newGame)
        print("button new")
        
        if (stage >= 1) {
            // MARK: Button Continue
            continueButton = SKSpriteNode(imageNamed: "continueButton")
            continueButton.zPosition = 2
            continueButton.position = CGPoint(x: 0, y: -250)
            continueButton.size = CGSize(width: 500, height: 100)
            addChild(continueButton)
            print("button continue")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let transition = SKTransition.fade(with: .black, duration: 5)
            
            if newGame.contains(location) {
                print("button new clicked")
                let scene = ExamTransition()
                scene.stage = 1
                scene.size = CGSize(width: frame.width, height: frame.height)
                self.view?.presentScene(scene, transition: transition)
            }
            else if stage > 1 && continueButton.contains(location) {
                if (stage >= 1) {
                    
                    print("button continue clicked")
                    let scene = ExamTransition()
                    scene.stage = stage
                    scene.size = CGSize(width: frame.width, height: frame.height)
                    self.view?.presentScene(scene, transition: transition)
                }
                
            }
        }
    }
}
