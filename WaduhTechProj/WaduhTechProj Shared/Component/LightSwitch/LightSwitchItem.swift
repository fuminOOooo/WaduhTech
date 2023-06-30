//
//  LightItem.swift
//  WaduhTechProj iOS
//
//  Created by Naufal R. Ariekananda on 25/06/23.
//

import Foundation
import SpriteKit

class LightSwitchItem: SKSpriteNode {
    
    init (scene: SKScene) {
        // Create and add your sprite node
        let lightTexture : SKTexture? = SKTexture(imageNamed: "onSwitch")
        let lightSize = CGSize(width: 83, height: 62)
        
        super.init(texture: lightTexture, color: UIColor.clear, size: lightSize)
        
        scene.addChild(self)
        
        self.zPosition = 1.0
        self.position = CGPoint(x: scene.frame.midX+256, y: scene.frame.midY+190)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
