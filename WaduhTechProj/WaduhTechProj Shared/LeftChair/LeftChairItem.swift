//
//  LeftChairItem.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 30/06/23.
//

import Foundation
import SpriteKit

class LeftChairItem: SKSpriteNode {
    
    init(scene: SKScene) {
        
        let leftChairSize = CGSize(width: 200, height: 200)
        let leftChairTexture = SKTexture(imageNamed: "kursiTap1_1")
        
        super.init(texture: leftChairTexture, color: UIColor.clear, size: leftChairSize)
        
        scene.addChild(self)
        
        self.zPosition = 1.0
        self.position = CGPoint(x: frame.midX-240, y: frame.midY-180)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
