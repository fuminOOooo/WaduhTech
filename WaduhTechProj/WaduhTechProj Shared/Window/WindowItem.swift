//
//  WindowSprite.swift
//  WaduhTechProj iOS
//
//  Created by Elvis Susanto on 22/06/23.
//

import Foundation
import SpriteKit

class WindowItem: SKSpriteNode {
    
    init (aWindow: WindowScene, scene: SKScene) {
        // Create and add your sprite node
        let windowTexture : SKTexture? = SKTexture(imageNamed: "Untitled_Artwork 1")
        let windowSize = CGSize(width: 100, height: 100)
        
        super.init(texture: windowTexture, color: UIColor.clear, size: windowSize)
        
        scene.addChild(self)
        
        self.position = CGPoint(x: frame.midX, y: frame.midY)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
