//
//  WindowSprite.swift
//  WaduhTechProj iOS
//
//  Created by Elvis Susanto on 25/06/23.
//

import Foundation
import SpriteKit

class ExamItem: SKSpriteNode {
    
    init (scene: SKScene) {
        // Create and add your sprite node
        let examTexture : SKTexture? = SKTexture(imageNamed: "examPaper")
        let examSize = CGSize(width: scene.frame.width, height: scene.frame.height)
        super.init(texture: examTexture, color: UIColor.clear, size: examSize)
        
        scene.addChild(self)
        
        self.zPosition = -1.0
        self.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
