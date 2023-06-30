//
//  WindowSprite.swift
//  WaduhTechProj iOS
//
//  Created by Elvis Susanto on 25/06/23.
//

import Foundation
import SpriteKit

class ExamTableItem: SKSpriteNode {
    
    init (scene: SKScene) {
        // Create and add your sprite node
        let examTableTexture: SKTexture? = SKTexture(imageNamed: "examPaper")
        let examTableSize = CGSize(width: 454, height: 242)
        super.init(texture: examTableTexture, color: UIColor.clear, size: examTableSize)
        
        self.position = CGPoint(x: scene.frame.midX-5, y: scene.frame.midY-392)
        
        self.zPosition = 1.0
        scene.addChild(self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
