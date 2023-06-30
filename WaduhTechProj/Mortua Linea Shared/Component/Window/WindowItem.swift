//
//  WindowSprite.swift
//  WaduhTechProj iOS
//
//  Created by Elvis Susanto on 22/06/23.
//

import Foundation
import SpriteKit

class WindowItem: SKSpriteNode {
    
    init (scene: SKScene) {
        // Create and add your sprite node
        let windowTexture : SKTexture? = SKTexture(imageNamed: "windowState1")
        let windowSize = CGSize(width: 200, height: 524)
        
        super.init(texture: windowTexture, color: UIColor.clear, size: windowSize)
        
        scene.addChild(self)
        
        self.zPosition = 1.0
        self.position = CGPoint(x: scene.frame.midX-583, y: scene.frame.midY+65)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
