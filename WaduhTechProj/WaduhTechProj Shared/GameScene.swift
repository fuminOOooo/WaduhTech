//
//  GameScene.swift
//  WaduhTechProj Shared
//
//  Created by Elvis Susanto on 20/06/23.
//

import SwiftUI
import SpriteKit
import GameplayKit

class GameScene: SKScene {
        
    // Exam
    var examOpen: Bool = false {
        didSet {
            if examOpen {
                // Turn on sound effects
                aBlackboard.enableSoundEffects()
                aDrawer.enableSoundEffects()
            } else {
                // Turn off sound effects
                aBlackboard.disableSoundEffects()
                aDrawer.disableSoundEffects()
            }
        }
    }
    
    var examNode: ExamItem!
    var aExam: ExamScene!
    
    // Exam Table
    var examTableNode: ExamTableItem!
    var aExamTable: ExamTableScene!
    
    // Light
//    var lightNode: LightItem!
//    var aLight: LightScene!
    
    // Blackboard
    var blackboardNode: BlackboardItem!
    var aBlackboard: BlackboardScene!
    
    // Closet
    var drawerNode: DrawerItem!
    var aDrawer: DrawerScene!

    // Window
    var isHeld: Bool = false
    var windowNode: WindowItem!
    var aWindow: WindowScene!
    
    var isGameOver: Bool = false
    
    var startLocation: CGPoint? = nil
    var whichTouchIndicator = 0
    // 0 = Touch with no sprite
    // 1 = Touch inside window
    // 2 = Touch inside blackboard
    // 3 = Touch inside closet
    
    var globalTimer = Timer()
    var timeRemaining: TimeInterval = 20.0 {
        didSet
        {
            if !lightSwitch {
                darken()
            }
        }
    }
    var totalDuration: TimeInterval = 20.0
    var globalTimerLabel: SKLabelNode!
    var darkOverlay: SKSpriteNode!
    var lightSwitch: Bool = false
    
    override func update(_ currentTime: TimeInterval) {
        
        globalTimerLabel.text = "\(Int(timeRemaining))"
        globalTimerLabel.zPosition = 10.0
        
        if ((aWindow.timeRemaining == 0 || aBlackboard.counter == 0 || aDrawer.counter == 0 || timeRemaining == 0) && (isGameOver == false)) {
            aWindow.countdownTimer?.invalidate()
            aDrawer.countdownTimer.invalidate()
            aBlackboard.countdownTimer.invalidate()
            isGameOver = true
            moveToGameOver()
        }
        
    }
    
    func changeZPositions() {
        
        if examOpen {
            aExam.spriteNode.zPosition = 3.0
            aExam.exitLabel.zPosition = 4.0
            aBlackboard.soundEnabled = true
        }
        
        else if !examOpen {
            aExam.spriteNode.zPosition = -2.0
            aExam.exitLabel.zPosition = -1.0
            aBlackboard.soundEnabled = false
        }
        
    }
    
    override func didMove(to view: SKView) {
        
        globalTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            if timeRemaining > 0 {
                timeRemaining -= 1.0
            }
        }
        
        globalTimerLabel = SKLabelNode(text: "\(Int(timeRemaining))")
        globalTimerLabel.position = CGPoint(x: 300, y: 300)
        globalTimerLabel.fontColor = .black
        globalTimerLabel.zPosition = 6
        addChild(globalTimerLabel)
        
        aExam = ExamScene(scene: self)
        aDrawer = DrawerScene(scene: self)
        aBlackboard = BlackboardScene(scene: self)
        aWindow = WindowScene(scene: self)
        aExamTable = ExamTableScene(scene: self)
        
        examNode = ExamItem(scene: self)
        windowNode = WindowItem(scene: self)
        blackboardNode = BlackboardItem(scene: self)
        drawerNode = DrawerItem(scene: self)
        examTableNode = ExamTableItem(scene: self)
        
        aExam.spriteNode = examNode
        aWindow.spriteNode = windowNode
        aBlackboard.spriteNode = blackboardNode
        aDrawer.spriteNode = drawerNode
        aExamTable.spriteNode = examTableNode
        
//        aExam.scene.zPosition = -2.0
        
        // Timer label window
        aWindow.timerLabel = SKLabelNode(text: "\(Int(aWindow.timeRemaining))")
        aWindow.timerLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(aWindow.timerLabel)
        
        // Timer label blackboard
        timerBlackboard.position = CGPoint(x: 0,y: 100)
        addChild(timerBlackboard)
        aBlackboard.timerBlackboard = timerBlackboard
        
        // Timer label drawer
        timerDrawer.position = CGPoint(x: 200, y: 100)
        addChild(timerDrawer)
        aDrawer.timerDrawer = timerDrawer
        
        aExam.exitLabel = SKSpriteNode(imageNamed: "examPaper")
        aExam.exitLabel.position = CGPoint(x: frame.maxX-200, y: frame.maxY-200)
        aExam.exitLabel.size = CGSize(width: 30, height: 30)
        addChild(aExam.exitLabel)
        
        darkOverlay = SKSpriteNode(color: .black, size: self.size)
        darkOverlay.position = CGPoint(x: frame.midX, y: frame.midY)
        darkOverlay.size = CGSize(width: frame.width, height: frame.height)
        addChild(darkOverlay)
        
        darkOverlay.alpha = 0
        darkOverlay.zPosition = 20.0
        
        aExam.exitLabel.zPosition = -1.0
        
        // Start the blackboard countdown
        aBlackboard.startCountdown()
        
        // Start the window countdown timer
        aWindow.startCountdown()
        
        // Start the drawer counter timer
        aDrawer.startCountdown()
        
    }
    
    //Dark Overlay
    @objc func darken() {
        if timeRemaining / totalDuration <= 0.2 {
            darkOverlay.alpha = 0.95
        } else if timeRemaining / totalDuration <= 0.4 {
            darkOverlay.alpha = 0.75
        } else if timeRemaining / totalDuration <= 0.6 {
            darkOverlay.alpha = 0.50
        } else if timeRemaining / totalDuration <= 0.8 {
            darkOverlay.alpha = 0.25
        }
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
    
    @objc func moveToGameOver() {
        let gameOverScene = GameOver(fileNamed: "GameOver")!
        gameOverScene.scaleMode = .aspectFit
        gameOverScene.win = false
        self.view!.presentScene(gameOverScene)
    }
    
    // Label Timer Blackboard
    lazy var timerBlackboard: SKLabelNode = {
        var label = SKLabelNode()
        label.fontColor = SKColor.black
        label.text = "\(aBlackboard.timeRemaining)"
        return label
    }()
    
    // Label Timer Blackboard
    lazy var timerDrawer: SKLabelNode = {
        var label = SKLabelNode()
        label.fontColor = SKColor.black
        label.text = "\(aDrawer.timeRemaining)"
        return label
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        // Began for window
        if (isHeld == false && !examOpen) {
            
            if (aExamTable.spriteNode.contains(touchLocation)) {
                examOpen.toggle()
                changeZPositions()
            }
            
            else if (drawerNode.contains(touchLocation)) {
                print("start drawer")
                startLocation = touchLocation
                whichTouchIndicator = 3
            }
            
            else if (blackboardNode.contains(touchLocation)) {
                print("start blackboard")
                startLocation = touchLocation
                whichTouchIndicator = 2
                
            }
            
            else if (aWindow.spriteNode.contains(touchLocation)) {
                isHeld.toggle()
                whichTouchIndicator = 1
                
                print("touch inside window detected!")
                
                aWindow.holdTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
                
                // Window timer stops
                aWindow.countdownTimer?.invalidate()
                aWindow.countdownTimer = nil
                
                aWindow.touchStartTime = touch.timestamp
            }
            
        } else if examOpen {
            
            if (aExam.exitLabel.contains(touchLocation)) {
                examOpen.toggle()
                changeZPositions()
            }
            
        }
        
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 2nd Person View Interactions
        if !examOpen {
            
            // Ended for window
            if (whichTouchIndicator == 1 && isHeld == true) {
                print("hold ended!")
                isHeld.toggle()
                aWindow.holdTimer?.invalidate()
                aWindow.holdTimer = nil
                
                // Window timer starts
                aWindow.startCountdown()
            }
        
            // Ended for blackboard and drawer
            else if ((whichTouchIndicator == 2 || whichTouchIndicator == 3) && isHeld == false) {
                
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
                        if node == blackboardNode {
                            continue // Skip right swipe for blackboard
                        }
                        
                        node.texture = SKTexture(imageNamed: node == drawerNode ? "closedCupboard" : "blackboard4")
                        print(node == drawerNode ? "drawer swiped right" : "blackboard swiped right")
                        
                        if node == drawerNode {
                            aDrawer.startCountdown() // Reset drawer timer
                        }
                    } else if translation.x < -swipeDistanceThreshold && translation.y < swipeDistanceThreshold {
                        // Left swipe
                        if node == drawerNode {
                            continue // Skip right swipe for blackboard
                        }
                        
                        node.texture = SKTexture(imageNamed: node == drawerNode ? "openedCupboard" : "blackboard")
                        print(node == drawerNode ? "drawer swiped left" : "blackboard swiped left")

                        if node == blackboardNode {
                            aBlackboard.startCountdown() // Reset blackboard timer
                        }
                    }
                }
                    self.startLocation = nil
            }
        }
        
            whichTouchIndicator = 0
            
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

