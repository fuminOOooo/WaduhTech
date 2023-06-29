//
//  ExamScene.swift
//  WaduhTechProj iOS
//
//  Created by Elvis Susanto on 27/06/23.
//

import SpriteKit

struct ExamSheetScene {
    
    var spriteNode : SKSpriteNode!
    var question: SKLabelNode!
    var labelAnswerA: SKLabelNode!
    var labelAnswerB: SKLabelNode!
    var labelAnswerC: SKLabelNode!
    var labelAnswerD: SKLabelNode!
    var nextQuestion: SKLabelNode!
    var prevQuestion: SKLabelNode!
    var scene: SKScene!
    init(scene: SKScene) {
        self.scene = scene
    }
}
