//
//  MainMenu.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 25/06/23.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {
    
    var buttonPlay: SKSpriteNode!
    var startLocation: CGPoint? = nil

    override func didMove(to view: SKView) {
        buttonPlay = SKSpriteNode(imageNamed: "playButton")
        buttonPlay.zPosition = 2
        buttonPlay.position = CGPoint(x: 0, y: -200)
        buttonPlay.size = CGSize(width: 500, height: 100)
        addChild(buttonPlay)
        print("button loaded")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if buttonPlay.contains(location) {
                print("button play clicked")
                startLocation = location
                let scene = GameScene(fileNamed: "GameScene")
                scene!.scaleMode = .aspectFit
                self.view?.presentScene(scene)
            }
        }
    }
}
