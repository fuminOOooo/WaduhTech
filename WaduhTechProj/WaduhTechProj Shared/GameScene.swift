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
                        aWindow.enableSoundEffects()
                        if stage >= 3 {
                            //                            aLaci.enableSoundEffects()
                            if stage >= 4 {
                                //                                aTV.enableSoundEffects()
                            }
                        }
                    }
                }
                
            } else {
                // Turn off sound effects
                if stage >= 1 {
                    aDrawer.disableSoundEffects()
                    if stage >= 2 {
                        aBlackboard.disableSoundEffects()
                        aWindow.disableSoundEffects()
                        if stage >= 3 {
                            //                            aLaci.disableSoundEffects()
                            if stage >= 4 {
                                //                                aTV.disableSoundEffects()
                            }
                        }
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
    
    // Cupboard
    var drawerNode: DrawerItem!
    var aDrawer: DrawerScene!
    
    // Window
    var windowNode: WindowItem!
    var aWindow: WindowScene!
    
    // Drawer
    var laciNode: LaciItem!
    var aLaci: LaciScene!
    
    var isHeld: Bool = false
    var isGameOver: Bool = false
    
    var startLocation: CGPoint? = nil
    var whichTouchIndicator = 0
    // 0 = Touch with no sprite
    // 1 = Touch inside cupboard
    // 2 = Touch inside blackboard
    // 3 = Touch inside window
    // 4 = Touch inside drawer
    // 5 = Touch inside TV
    
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
        
        else if ((stage >= 2) && (aBlackboard.counter == 0 || aDrawer.counter == 0 || aWindow.counter == 0 || timeRemaining == 0) && (isGameOver == false)) {
            aDrawer.countdownTimer.invalidate()
            aBlackboard.countdownTimer.invalidate()
            aWindow.countdownTimer.invalidate()
            isGameOver = true
            moveToGameOver()
        }
        
        else if ((stage >= 3) && (aBlackboard.counter == 0 || aDrawer.counter == 0 || aWindow.counter == 0 || aLaci.timeRemaining == 0 || timeRemaining == 0) && (isGameOver == false)) {
            // TODO: Drawer, blackboard, window, all item that use hold gesture
            aDrawer.countdownTimer.invalidate()
            aBlackboard.countdownTimer.invalidate()
            aWindow.countdownTimer.invalidate()
            aLaci.countdownTimer?.invalidate()
            isGameOver = true
            moveToGameOver()
        }
        
        else if ((stage >= 4) && (aBlackboard.counter == 0 || aDrawer.counter == 0 || aWindow.counter == 0 || aLaci.timeRemaining == 0 || /* aTV.timeRemaining ||*/ timeRemaining == 0) && (isGameOver == false)) {
            // TODO: Drawer, blackboard, window, all item that use hold gesture
            aDrawer.countdownTimer.invalidate()
            aBlackboard.countdownTimer.invalidate()
            aWindow.countdownTimer.invalidate()
            aLaci.countdownTimer?.invalidate()
            //            aTV.countdownTimer.invalidate()
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
            timerCupboard.position = CGPoint(x: 200, y: 100)
            addChild(timerCupboard)
            aDrawer.timerCupboard = timerCupboard
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
                timerBlackboard.position = CGPoint(x: frame.midX,y: frame.midY+100)
                addChild(timerBlackboard)
                aBlackboard.timerBlackboard = timerBlackboard
                // Start the blackboard countdown
                aBlackboard.startCountdown()
                
                // MARK: Window Item
                aWindow = WindowScene(scene: self)
                windowNode = WindowItem(scene: self)
                aWindow.spriteNode = windowNode
                // Timer label window
                timerWindow.position = CGPoint(x: frame.midX, y: frame.midY)
                addChild(timerWindow)
                aWindow.timerWindow = timerWindow
                // Start the window countdown timer
                aWindow.startCountdown()
                
                if (stage >= 3) {
                    timeRemaining = 330.0
                    totalDuration = 330.0
                    
                    // MARK: Laci Item
                    aLaci = LaciScene(scene: self)
                    laciNode = LaciItem(scene: self)
                    aLaci.spriteNode = laciNode
                    // Timer label drawer
                    aLaci.timerDrawer.position = CGPoint(x: frame.midX, y: frame.midY)
                    addChild(aLaci.timerDrawer)
                    aLaci.timerDrawer = SKLabelNode(text: "\(Int(aLaci.timeRemaining))")
                    //Start drawer countdown timer
                    aLaci.startCountdown()
                    
                    if (stage >= 4) {
                        timeRemaining = 360.0
                        totalDuration = 360.0
                        
                        // MARK: TV item
                        //                        aTV = TVScene(scene: self)
                        //                        tvNode = TVItem(scene: self)
                        //                        aTV.spriteNode = tvNode
                        //                        // Timer label drawer
                        //                        aTV.timerDrawer.position = CGPoint(x: frame.midX, y: frame.midY)
                        //                        addChild(aLaci.timerDrawer)
                        //                        aTV.timerDrawer = SKLabelNode(text: "\(Int(aTV.timeRemaining))")
                        //                        //Start drawer countdown timer
                        //                        aTV.startCountdown()
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
    
    // Khusus Drawer
    @objc func fireTimer() {
        print("Timer fired!")
        if aLaci.timeRemaining == 10 {
            aLaci.timeRemaining = 10
        } else if aLaci.timeRemaining < 10 {
            aLaci.timeRemaining += 0.5
        }
    }
    
    //    // Khusus TV
    //    @objc func fireTimerTV() {
    //        print("Timer fired!")
    //        if aTV.timeRemaining == 10 {
    //            aTV.timeRemaining = 10
    //        } else if aTV.timeRemaining < 10 {
    //            aTV.timeRemaining += 0.5
    //        }
    //    }
    
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
    lazy var timerCupboard: SKLabelNode = {
        var label = SKLabelNode()
        label.fontColor = SKColor.black
        label.text = "\(aDrawer.timeRemaining)"
        return label
    }()
    
    // Label Timer Window
    lazy var timerWindow: SKLabelNode = {
        var label = SKLabelNode()
        label.fontColor = SKColor.black
        label.text = "\(aWindow.timeRemaining)"
        return label
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        if (isHeld == false && !examOpen) {
            
            // MARK: Began for Tap Gesture
            if (aExamTable.spriteNode.contains(touchLocation)) {
                examOpen.toggle()
                changeZPositions()
            }
            
            // MARK: Began for Swipe Gesture
            else if (drawerNode.contains(touchLocation)) {
                print("start drawer")
                startLocation = touchLocation
                whichTouchIndicator = 1
            }
            
            else if (blackboardNode != nil && blackboardNode.contains(touchLocation)) {
                print("start blackboard")
                startLocation = touchLocation
                whichTouchIndicator = 2
                
            }
            
            else if (windowNode != nil && windowNode.contains(touchLocation)) {
                print("start window")
                startLocation = touchLocation
                whichTouchIndicator = 3
            }
            
            // MARK: Began for Hold Gesture
            
            else if (aLaci != nil && aLaci.spriteNode.contains(touchLocation)) {
                isHeld.toggle()
                whichTouchIndicator = 4
                
                print("touch inside window detected!")
                
                aLaci.holdTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
                
                // Laci timer stops
                aLaci.countdownTimer?.invalidate()
                aLaci.countdownTimer = nil
                
                aLaci.touchStartTime = touch.timestamp
            }
            
            //            else if (aTV != nil && aTV.spriteNode.contains(touchLocation)) {
            //                isHeld.toggle()
            //                whichTouchIndicator = 4
            //
            //                print("touch inside window detected!")
            //
            //                aTV.holdTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fireTimer2), userInfo: nil, repeats: true)
            //
            //                // Laci timer stops
            //                aTV.countdownTimer?.invalidate()
            //                aTV.countdownTimer = nil
            //
            //                aTV.touchStartTime = touch.timestamp
            //            }
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
            
            // Ended for blackboard and drawer
            if ((whichTouchIndicator == 1 || whichTouchIndicator == 2 || whichTouchIndicator == 3) && isHeld == false) {
                
                guard let startLocation = startLocation else { return }
                for touch in touches {
                    let endLocation = touch.location(in: self)
                    let translation = CGPoint(x: endLocation.x - startLocation.x, y: endLocation.y - startLocation.y)
                    let swipeDistanceThreshold: CGFloat = 50.0
                    
                    var nodeToUpdate: SKSpriteNode?
                    
                    if whichTouchIndicator == 1 {
                        nodeToUpdate = drawerNode
                    } else if whichTouchIndicator == 2 {
                        nodeToUpdate = blackboardNode
                    } else if whichTouchIndicator == 3 {
                        nodeToUpdate = windowNode
                    }
                    
                    if let node = nodeToUpdate {
                        if translation.x > swipeDistanceThreshold && translation.y < swipeDistanceThreshold {
                            // Right swipe
                            if node == blackboardNode {
                                continue // Skip right swipe for blackboard
                            }
                            else if node == drawerNode {
                                drawerNode.texture = SKTexture(imageNamed: "closedCupboard")
                                print("drawer swiped right")
                                aDrawer.startCountdown()
                            }
                            else if node == windowNode {
                                windowNode.texture = SKTexture(imageNamed: "Untitled_Artwork 1")
                                print("window swiped right")
                                aWindow.startCountdown()
                            }
                        } else if translation.x < -swipeDistanceThreshold && translation.y < swipeDistanceThreshold {
                            // Left swipe
                            if node == drawerNode || node == windowNode{
                                continue // Skip right swipe for blackboard
                            }
                            else if node == blackboardNode {
                                blackboardNode.texture = SKTexture(imageNamed: "blackboard")
                                print("blackboard swiped left")
                                aBlackboard.startCountdown()
                            }
                        }
                    }
                    self.startLocation = nil
                }
            }
            // Ended for window
            else if (whichTouchIndicator == 4 && isHeld == true) {
                print("hold ended!")
                isHeld.toggle()
                aLaci.holdTimer?.invalidate()
                aLaci.holdTimer = nil
                
                // Window timer starts
                aLaci.startCountdown()
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

