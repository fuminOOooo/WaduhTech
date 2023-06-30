//
//  TVItem.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 28/06/23.
//

import Foundation
import SpriteKit

class TVItem: SKSpriteNode {
    
    init(scene: SKScene) {
        let tvSize = CGSize(width: 150, height: 150)
        let tvTexture = SKTexture(imageNamed: "tv_1")
        
        super .init(texture: tvTexture, color: UIColor.clear, size: tvSize)
        
        scene.addChild(self)
        self.zPosition = 1.0
        self.position = CGPoint(x: scene.frame.midX-280, y: scene.frame.midY+280)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
