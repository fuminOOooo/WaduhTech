//
//  PauseButton.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 30/06/23.
//

import Foundation
import SpriteKit

class PauseButton: SKSpriteNode {
    var pauseButton: SKSpriteNode!

    init(scene: SKScene) {
        
        let pauseTexture = SKTexture(imageNamed: "pauseButton")
        let pauseSize = CGSize(width: 70, height: 70)
        super.init(texture: pauseTexture, color: UIColor.clear, size: pauseSize)
        
        scene.addChild(self)

        self.zPosition = 1.0
        self.position = CGPoint(x: scene.frame.maxX-100, y: scene.frame.maxY-100)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
