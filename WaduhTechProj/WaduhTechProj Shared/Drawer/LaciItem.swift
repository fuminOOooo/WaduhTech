//
//  LaciItem.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 28/06/23.
//

import Foundation
import SpriteKit

class LaciItem: SKSpriteNode {
    
    init(scene: SKScene) {

        let laciSize = CGSize(width: 200, height: 400)
        let laciTexture = SKTexture(imageNamed: "Untitled_Artwork 1")

        super.init(texture: laciTexture, color: UIColor.clear, size: laciSize)

        // Add the box node to the scene
        scene.addChild(self)
        
        self.zPosition = 1.0
        self.position = CGPoint(x: scene.frame.midX-200, y: scene.frame.midY+50)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
