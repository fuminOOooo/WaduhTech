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
    
    var stage: Int = 0
        
    // Exam
    var examOpen: Bool = false {
        didSet {
            if examOpen {
                // Turn on sound effects
                if stage >= 1 {
                    aDrawer.enableSoundEffects()
                    if stage >= 2 {
                        aBlackboard.enableSoundEffects()
                    }
                }
                
            } else {
                // Turn off sound effects
                if stage >= 1 {
                    aDrawer.disableSoundEffects()
                    if stage >= 2 {
                        aBlackboard.disableSoundEffects()
                    }
                }
            }
        }
    }
    var buttonTest: SKSpriteNode!
    
    var examNode: ExamItem!
    var aExam: ExamScene!
    
    // Exam Table
    var examTableNode: ExamTableItem!
    var aExamTable: ExamTableScene!
    
    // Light
//    var lightNode: LightItem!
//    var aLight: LightScene!
    
    var bg: SKSpriteNode!
    var bgTexture: SKTexture = SKTexture(imageNamed: "background")
    
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
    var timeRemaining: TimeInterval = 0.0 {
        didSet
        {
            if !lightSwitch {
                darken()
            }
        }
    }
    var totalDuration: TimeInterval = 0.0
    var globalTimerLabel: SKLabelNode!
    var darkOverlay: SKSpriteNode!
    var lightSwitch: Bool = false
    
    override func update(_ currentTime: TimeInterval) {
        
        globalTimerLabel.text = "\(Int(timeRemaining))"
        globalTimerLabel.zPosition = 10.0
        
        if ((stage >= 1) && (aDrawer.counter == 0 || timeRemaining == 0) && (isGameOver == false)) {
            aDrawer.countdownTimer.invalidate()
            isGameOver = true
            moveToGameOver()
        }
        
        else if ((stage >= 2) && (aBlackboard.counter == 0 || aDrawer.counter == 0 || timeRemaining == 0) && (isGameOver == false)) {
            aDrawer.countdownTimer.invalidate()
            aBlackboard.countdownTimer.invalidate()
            aWindow.countdownTimer?.invalidate()
            isGameOver = true
            moveToGameOver()
        }
        
        else if ((stage >= 3) && (aWindow.timeRemaining == 0 || aBlackboard.counter == 0 || aDrawer.counter == 0 || timeRemaining == 0) && (isGameOver == false)) {
            // TODO: Drawer, blackboard, window, all item that use hold gesture
            aDrawer.countdownTimer.invalidate()
            aBlackboard.countdownTimer.invalidate()
            aWindow.countdownTimer?.invalidate()
            isGameOver = true
            moveToGameOver()
        }
        
    }
    
    // MARK: Changing ZPosition of Exam
    func changeZPositions() {
        
        if examOpen {
            aExam.spriteNode.zPosition = 3.0
            aExam.exitLabel.zPosition = 4.0
        }
        else if !examOpen {
            aExam.spriteNode.zPosition = -2.0
            aExam.exitLabel.zPosition = -1.0
        }
        
    }
    
    override func didMove(to view: SKView) {
        
        print(stage)
        
        globalTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            if timeRemaining > 0 {
                timeRemaining -= 1.0
            }
        }
        
        bg = SKSpriteNode(texture: bgTexture)
        bg.position = CGPoint(x: frame.midX, y: frame.midY)
        bg.size = CGSize(width: frame.width, height: frame.height)
        addChild(bg)
        bg.zPosition = -0.0
        
        globalTimerLabel = SKLabelNode(text: "\(Int(timeRemaining))")
        globalTimerLabel.position = CGPoint(x: 300, y: 300)
        globalTimerLabel.fontColor = .black
        globalTimerLabel.zPosition = 6
        addChild(globalTimerLabel)
        
        aExam = ExamScene(scene: self)
        examNode = ExamItem(scene: self)
        aExam.spriteNode = examNode
        aExam.exitLabel = SKSpriteNode(imageNamed: "examPaper")
        aExam.exitLabel.position = CGPoint(x: frame.maxX-200, y: frame.maxY-200)
        aExam.exitLabel.size = CGSize(width: 30, height: 30)
        addChild(aExam.exitLabel)
        aExam.exitLabel.zPosition = -1.0
        
        aExamTable = ExamTableScene(scene: self)
        examTableNode = ExamTableItem(scene: self)
        aExamTable.spriteNode = examTableNode
        
        darkOverlay = SKSpriteNode(color: .black, size: self.size)
        darkOverlay.position = CGPoint(x: frame.midX, y: frame.midY)
        darkOverlay.size = CGSize(width: frame.width, height: frame.height)
        addChild(darkOverlay)
        
        darkOverlay.alpha = 0
        darkOverlay.zPosition = 20.0
        
        // MARK: BUTTON BUAT TEST WIN CONDITION
        buttonTest = SKSpriteNode(color: .red, size: CGSize(width: 200, height: 100))
        buttonTest.position = CGPoint(x: frame.midX, y: frame.midY-100)
        buttonTest.zPosition = +5
        addChild(buttonTest)
        
        // MARK: Setup Stage Timer and Obstacle
        if (stage >= 1) {
            // MARK: Cupboard Item
            timeRemaining = 240.0
            totalDuration = 240.0
            aDrawer = DrawerScene(scene: self)
            drawerNode = DrawerItem(scene: self)
            aDrawer.spriteNode = drawerNode
            // Timer label drawer
            timerDrawer.position = CGPoint(x: 200, y: 100)
            addChild(timerDrawer)
            aDrawer.timerDrawer = timerDrawer
            // Start the drawer counter timer
            aDrawer.startCountdown()
            
            if (stage >= 2) {
                timeRemaining = 300.0
                totalDuration = 300.0
                
                // MARK: Blackboard Item
                aBlackboard = BlackboardScene(scene: self)
                blackboardNode = BlackboardItem(scene: self)
                aBlackboard.spriteNode = blackboardNode
                // Timer label blackboard
                timerBlackboard.position = CGPoint(x: 0,y: 100)
                addChild(timerBlackboard)
                aBlackboard.timerBlackboard = timerBlackboard
                // Start the blackboard countdown
                aBlackboard.startCountdown()
                
                // MARK: Window Item
                timeRemaining = 330.0
                totalDuration = 330.0
                aWindow = WindowScene(scene: self)
                windowNode = WindowItem(scene: self)
                aWindow.spriteNode = windowNode
                // Timer label window
                aWindow.timerLabel = SKLabelNode(text: "\(Int(aWindow.timeRemaining))")
                aWindow.timerLabel.position = CGPoint(x: frame.midX, y: frame.midY)
                addChild(aWindow.timerLabel)
                // Start the window countdown timer
                aWindow.startCountdown()
                
                if (stage >= 3) {
                    timeRemaining = 330.0
                    totalDuration = 330.0
                    
                    // MARK: Laci Item
                    
                    
                    if (stage >= 4) {
                        timeRemaining = 360.0
                        totalDuration = 360.0
                        
                        // MARK: TV item
                    }
                }
            }
        }
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
        let scene = GameOver()
        scene.stage = stage+1
        scene.size = CGSize(width: frame.width, height: frame.height)
        self.view?.presentScene(scene)
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
            
            else if (blackboardNode != nil && blackboardNode.contains(touchLocation)) {
                print("start blackboard")
                startLocation = touchLocation
                whichTouchIndicator = 2
                
            }
            
            // MARK: Began for Window

            else if (aWindow != nil && aWindow.spriteNode.contains(touchLocation)) {
                isHeld.toggle()
                whichTouchIndicator = 1
                
                print("touch inside window detected!")
                
                aWindow.holdTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
                
                // Window timer stops
                aWindow.countdownTimer?.invalidate()
                aWindow.countdownTimer = nil
                
                aWindow.touchStartTime = touch.timestamp
            }
            
            else if (buttonTest != nil && buttonTest.contains(touchLocation)) {
                isHeld.toggle()
                let scene = ExamTransition()
                scene.stage = stage+1
                scene.size = CGSize(width: frame.width, height: frame.height)
                let transition = SKTransition.fade(with: .black, duration: 5)
                self.view?.presentScene(scene, transition: transition)
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

