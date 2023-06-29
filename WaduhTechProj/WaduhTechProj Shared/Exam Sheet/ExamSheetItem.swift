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
        let examSheetSize = CGSize(width: 0, height: 0)
        super.init(texture: examSheetTexture, color: UIColor.clear, size: examSheetSize)
        
        scene.addChild(self)
        
        self.zPosition = -1.0
        self.position = CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
