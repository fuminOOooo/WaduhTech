//
//  DrawerItem.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 22/06/23.
//

import Foundation
import SpriteKit

class DrawerItem: SKSpriteNode{
    
    init(scene: SKScene) {

        let drawerSize = CGSize(width: 200, height: 400)
        let drawerColor = SKColor.white
        let drawerTexture = SKTexture(imageNamed: "closedCupboard")

        super.init(texture: drawerTexture, color: drawerColor, size: drawerSize)

        // Add the box node to the scene
        scene.addChild(self)
        
        self.zPosition = 1.0
        self.position = CGPoint(x: 540, y: -200)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
