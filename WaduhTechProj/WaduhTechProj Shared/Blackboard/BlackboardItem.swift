//
//  BlackboardItem.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 22/06/23.
//

import Foundation
import SpriteKit

class BlackboardItem: SKSpriteNode {
    
    init(scene: SKScene) {

        let blackboardSize = CGSize(width: 320, height: 192)
        let blackboardTexture = SKTexture(imageNamed: "blackboard")

        super.init(texture: blackboardTexture, color: UIColor.clear, size: blackboardSize)

        // Add the box node to the scene
        scene.addChild(self)
        
        self.zPosition = 1.0
        self.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY+287)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
