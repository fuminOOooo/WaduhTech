//
//  OnboardPage.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 02/07/23.
//

import Foundation
import SpriteKit

class OnboardPage: SKScene {
    var stage: Int = 4
    var timer = Timer()
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode()
        background.color = .black
        background.size = CGSize(width: frame.width, height: frame.height)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        let examLabel = SKLabelNode(attributedText: NSAttributedString(string: "Best played with headphones.", attributes: [.font: UIFont(name: "hulberthopperdisplay", size: 32)!, .foregroundColor: UIColor.white]))
        
        examLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(examLabel)
        
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(moveToExam), userInfo: nil, repeats: false)
        
    }
    
    @objc func moveToExam() {
        //Configure the new scene to be presented and then present.
        let scene = MainMenu()
        scene.stage = stage
        scene.size = CGSize(width: frame.width, height: frame.height)
        self.view?.presentScene(scene)
        
    }
    
    deinit {
        //Stops the timer.
        timer.invalidate()
    }
    
}

