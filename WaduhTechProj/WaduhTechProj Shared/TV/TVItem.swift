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
        let tvSize = CGSize(width: 200, height: 200)
        let tvTexture = SKTexture(imageNamed: "Untitled_Artwork 1")
        
        super .init(texture: tvTexture, color: UIColor.clear, size: tvSize)
        
        scene.addChild(self)
        self.zPosition = 1.0
        self.position = CGPoint(x: frame.midX+100, y: frame.midY+50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
