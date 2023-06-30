//
//  CupboardItem.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 22/06/23.
//

import Foundation
import SpriteKit

class CupboardItem: SKSpriteNode{
    
    init(scene: SKScene) {

        let cupboardSize = CGSize(width: 200, height: 473)
        let cupboardTexture = SKTexture(imageNamed: "closedCupboard")

        super.init(texture: cupboardTexture, color: UIColor.clear, size: cupboardSize)

        // Add the box node to the scene
        scene.addChild(self)
        
        self.zPosition = 1.0
        self.position = CGPoint(x: scene.frame.midX+500, y: scene.frame.midY-138)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
