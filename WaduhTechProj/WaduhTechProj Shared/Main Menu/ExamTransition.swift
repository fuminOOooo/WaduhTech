//
//  ExamTransition.swift
//  WaduhTechProj iOS
//
//  Created by Elvis Susanto on 26/06/23.
//

import Foundation
import SpriteKit

class ExamTransition: SKScene {
    var stage: Int = 0
    var timer = Timer()
    override func didMove(to view: SKView) {
        let background = SKSpriteNode()
        background.color = .black
        background.size = CGSize(width: frame.width, height: frame.height)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        let examLabel = SKLabelNode(text: "Exam \(stage)")
        examLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        examLabel.fontSize = CGFloat(60)
        examLabel.fontName = "SFPro"
        examLabel.fontColor = .white
        addChild(examLabel)
        
        timer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(moveToExam), userInfo: nil, repeats: false)
        
    }
    
    @objc func moveToExam() {
        //Configure the new scene to be presented and then present.
        let scene = GameScene()
        scene.stage = stage
        scene.size = CGSize(width: frame.width, height: frame.height)
        self.view?.presentScene(scene)
        
    }
    
    deinit {
        //Stops the timer.
        timer.invalidate()
    }
    
}
