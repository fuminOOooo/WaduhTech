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
                let scene = ExamTransition()
                scene.stage = 1
                scene.position = CGPoint(x: 0, y: 0)
                scene.size = CGSize(width: frame.width, height: frame.height)
                let transition = SKTransition.fade(with: .black, duration: 5)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
}
