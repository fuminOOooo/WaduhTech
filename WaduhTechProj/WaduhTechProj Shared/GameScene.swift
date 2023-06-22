//
//  GameScene.swift
//  WaduhTechProj Shared
//
//  Created by Elvis Susanto on 20/06/23.
//

import SpriteKit

class GameScene: SKScene {
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
//    var closetNode: closetItem!
    
    // Blackboard
    var blackboardNode: BlackboardItem!
    var aBlackboard = BlackboardScene()
    
    // Closet
    var drawerNode: DrawerItem!
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

    lazy var timerBlackboard: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "SF Pro")
        label.fontColor = SKColor.black
        label.text = "\(aBlackboard.countdownStart)"
        return label
    }()
    
    override func didMove(to view: SKView) {
        
        windowNode = WindowItem(aWindow: aWindow, scene: self)
        aWindow.spriteNode = windowNode
        
        blackboardNode = BlackboardItem(scene: self)
        aBlackboard.spriteNode = blackboardNode

        drawerNode = DrawerItem(scene: self)
        aDrawer.spriteNode = drawerNode

        // Timer label window
        aWindow.timerLabel = SKLabelNode(text: "\(Int(aWindow.timeRemaining))")
        aWindow.timerLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(aWindow.timerLabel)
        
        // Timer label blackboard
        timerBlackboard.position = CGPoint(x: 0,y: 200)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
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
        
        
        
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let startLocation = startLocation else { return }
        for touch in touches {
            let endLocation = touch.location(in: self)
            let translation = CGPoint(x: endLocation.x - startLocation.x, y: endLocation.y - startLocation.y)
            let swipeDistanceThreshold: CGFloat = 50.0
            
            var nodeToUpdate: SKSpriteNode?
            
            // Ended for window
            if (whichTouchIndicator == 1) {
                print("hold ended!")
                aWindow.holdTimer?.invalidate()
                aWindow.holdTimer = nil
                
                // Window timer starts
                aWindow.startCountdown()
                whichTouchIndicator = 0
            }
            else if (whichTouchIndicator == 2) {
                nodeToUpdate = blackboardNode
//                if whichTouchIndicator == 2 {
//                    nodeToUpdate = blackboardNode
//                } else if whichTouchIndicator == 3 {
//                    nodeToUpdate = closetNode
//                }
                
                if let node = nodeToUpdate {
                    if translation.x > swipeDistanceThreshold && translation.y < swipeDistanceThreshold {
                        // Right swipe
                        if node == blackboardNode {
                            continue // Skip right swipe for blackboard
                        }
                        node.texture = SKTexture(imageNamed: node == drawerNode ? "drawerOpen" : "blackboard4")
                        print("swiped right")
                    } else if translation.x < -swipeDistanceThreshold && translation.y < swipeDistanceThreshold {
                        // Left swipe
                        node.texture = SKTexture(imageNamed: node == drawerNode ? "drawerClosed" : "blackboardClear")
                        print("swiped left")
                        
                        if node == blackboardNode {
                            aBlackboard.startCountdown() // Reset the timer
                        }
                    }
                }
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

