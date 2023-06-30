//
//  LaciItem.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 28/06/23.
//

import Foundation
import SpriteKit

class DrawerItem: SKSpriteNode {
    
    init(scene: SKScene) {

        let drawerSize = CGSize(width: 100, height: 100)
        let drawerTexture = SKTexture(imageNamed: "drawer_1")

        super.init(texture: drawerTexture, color: UIColor.clear, size: drawerSize)

        // Add the box node to the scene
        scene.addChild(self)
        
        self.zPosition = 1.0
        self.position = CGPoint(x: scene.frame.midX-330, y: scene.frame.midY+80)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
