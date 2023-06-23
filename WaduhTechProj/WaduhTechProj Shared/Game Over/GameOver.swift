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
    
    public var win = true
    
    override func didMove(to view: SKView) {
        // Set up the scene
        let label = self.childNode(withName: "//gameOverLabel") as? SKLabelNode
        if win == false {
            label?.text = "Try again"
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = GameScene(fileNamed: "GameScene")
        scene!.scaleMode = .aspectFit
        self.view?.presentScene(scene)
    }
    
}
