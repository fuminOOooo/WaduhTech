//
//  GameScene.swift
//  WaduhTechProj Shared
//
//  Created by Elvis Susanto on 20/06/23.
//

import SpriteKit

class GameScene: SKScene {
        
    // Blackboard
//    var blackboardNode: BlackboardItem!
    var blackboardNode: SKSpriteNode!
    var aBlackboard = BlackboardScene()
    
    // Closet
//    var drawerNode: DrawerItem!
    var drawerNode: SKSpriteNode!
    var aDrawer = DrawerScene()

    // Window
    var windowNode: WindowItem!
    var aWindow = WindowScene()
    
    var whichTouchIndicator = 0
    // 0 = Touch with no sprite
    // 1 = Touch inside window
    // 2 = Touch inside blackboard
    // 3 = Touch inside closet
    
    var startLocation: CGPoint? = nil
    
    override func didMove(to view: SKView) {
        
        // coba coba
        blackboardNode = SKSpriteNode(imageNamed: "blackboardClear")
        blackboardNode.position = CGPoint(x: 0, y: 287)
        blackboardNode.size = CGSize(width: 320, height: 192)
        
        addChild(blackboardNode)
        
        drawerNode = SKSpriteNode(imageNamed: "drawerClosed")
        drawerNode.position = CGPoint(x: 250, y: 0)
        drawerNode.size = CGSize(width: 100, height: 100)

        addChild(drawerNode)
        
        windowNode = WindowItem(scene: self)
//        blackboardNode = BlackboardItem(scene: self)
//        drawerNode = DrawerItem(scene: self)

        aWindow.spriteNode = windowNode
        aBlackboard.spriteNode = blackboardNode
        aDrawer.spriteNode = drawerNode

        // Timer label window
        aWindow.timerLabel = SKLabelNode(text: "\(Int(aWindow.timeRemaining))")
        aWindow.timerLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(aWindow.timerLabel)
        
        // Timer label blackboard
        timerBlackboard.position = CGPoint(x: 0,y: 100)
        
        addChild(timerBlackboard)
        aBlackboard.timerBlackboard = timerBlackboard
        
        
        // Start the blackboard countdown
        aBlackboard.startCountdown()
        
        // Start the window countdown timer
        aWindow.startCountdown()
        
    }
    
    // Khusus Window
    @objc func fireTimer() {
        print("Timer fired!")
        if aWindow.timeRemaining == 10 {
            aWindow.timeRemaining = 10
        } else if aWindow.timeRemaining < 10 {
            aWindow.timeRemaining += 0.5
        }
    }
    
    // Label Timer Blackboard
    lazy var timerBlackboard: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "SF Pro")
        label.fontColor = SKColor.black
        label.text = "\(aBlackboard.timeRemaining)"
        return label
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            // Began for window
            if aWindow.spriteNode.contains(touchLocation) {
                
                whichTouchIndicator = 1
                
                aWindow.holdTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
                
                print("touch inside window detected!")
                
                // Window timer stops
                aWindow.countdownTimer?.invalidate()
                aWindow.countdownTimer = nil
                
                aWindow.touchStartTime = touch.timestamp
            }
            else if blackboardNode.contains(touchLocation) {
                print("start blackboard")
                startLocation = touchLocation
                whichTouchIndicator = 2
                
            }
            else if drawerNode.contains(touchLocation) {
                print("start drawer")
                startLocation = touchLocation
                whichTouchIndicator = 3
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            // Ended for window
            if (whichTouchIndicator == 1) {
                print("hold ended!")
                aWindow.holdTimer?.invalidate()
                aWindow.holdTimer = nil
                
                // Window timer starts
                aWindow.startCountdown()
                whichTouchIndicator = 0
            }
        
            // Ended for blackboard and drawer
            else if (whichTouchIndicator == 2 || whichTouchIndicator == 3) {
                guard let startLocation = startLocation else { return }
                for touch in touches {
                    let endLocation = touch.location(in: self)
                    let translation = CGPoint(x: endLocation.x - startLocation.x, y: endLocation.y - startLocation.y)
                    let swipeDistanceThreshold: CGFloat = 50.0
                    
                    var nodeToUpdate: SKSpriteNode?
                
                if whichTouchIndicator == 2 {
                    nodeToUpdate = blackboardNode
                } else if whichTouchIndicator == 3 {
                    nodeToUpdate = drawerNode
                }

                if let node = nodeToUpdate {
                    if translation.x > swipeDistanceThreshold && translation.y < swipeDistanceThreshold {
                        // Right swipe
//                        if node == blackboardNode {
//                            continue // Skip right swipe for blackboard
//                        }
                        
                        node.texture = SKTexture(imageNamed: node == drawerNode ? "drawerOpen" : "blackboard4")
                        print(node == drawerNode ? "drawer swiped right" : "blackboard swiped right")
                    } else if translation.x < -swipeDistanceThreshold && translation.y < swipeDistanceThreshold {
                        // Left swipe
                        node.texture = SKTexture(imageNamed: node == drawerNode ? "drawerClosed" : "blackboardClear")
                        print(node == drawerNode ? "drawer swiped left" : "blackboard swiped left")

                        if node == blackboardNode {
                            aBlackboard.startCountdown() // Reset the timer
                        }
                    }
                }
                    self.startLocation = nil
            }
        }
    }
}

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        self.makeSpinny(at: event.location(in: self), color: SKColor.green)
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.blue)
    }
    
    override func mouseUp(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.red)
    }

}
#endif

