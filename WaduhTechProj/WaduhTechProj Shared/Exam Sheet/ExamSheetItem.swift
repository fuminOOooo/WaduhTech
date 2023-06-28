//
//  WindowSprite.swift
//  WaduhTechProj iOS
//
//  Created by Elvis Susanto on 27/06/23.
//

import Foundation
import SpriteKit

class ExamSheetItem: SKSpriteNode {
    
    init (scene: SKScene) {
        // Create and add your sprite node
        let examSheetTexture: SKTexture? = SKTexture(imageNamed: "examSheet")
        let examSheetSize = CGSize(width: 542, height: 712)
        super.init(texture: examSheetTexture, color: UIColor.clear, size: examSheetSize)
        
        scene.addChild(self)
        
        self.zPosition = -1.0
        self.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
