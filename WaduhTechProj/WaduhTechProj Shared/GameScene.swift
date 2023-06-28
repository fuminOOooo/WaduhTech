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
    
    var currentQuestionsAndAnswers = QuestionsAndAnswers()
    var stage: Int = 0
    var questionNumber: Int = 1
    var nextQ: Bool = false
    
    // Exam
    var examOpen: Bool = false {
        
        didSet {
            
            if examOpen {
                
                changeQuestions()
                
                // Turn on sound effects
                if stage >= 1 {
                    aDrawer.enableSoundEffects()
                    if stage >= 2 {
                        aBlackboard.enableSoundEffects()
                    }
                }
                
            }
            
            if !examOpen {
                
                // Turn off sound effects
                if stage >= 1 {
                    aDrawer.disableSoundEffects()
                    if stage >= 2 {
                        aBlackboard.disableSoundEffects()
                    }
                }
                
            }
            
            changeZPositions()
            
        }
        
    }
    
    var examNode: ExamItem!
    var aExam: ExamScene!
    
    // Exam Table
    var examTableNode: ExamTableItem!
    var aExamTable: ExamTableScene!
    
    // Exam Sheet
    var examSheetNode: ExamSheetItem!
    var aExamSheet: ExamSheetScene!
    
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
    
    var timeRemaining: TimeInterval = 30.0 {
        didSet
        {
            if !lightSwitch {
                darken()
            }
        }
    }
    
    var totalDuration: TimeInterval = 30.0
    var globalTimerLabel: SKLabelNode!
    var darkOverlay: SKSpriteNode!
    var lightSwitch: Bool = false
    
    var firstTime: Bool = true
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        globalTimerLabel.text = "\(Int(timeRemaining))"
        globalTimerLabel.zPosition = 10.0
        
        if (nextQ == true) {
            changeQuestions()
        }
        
        if ((stage >= 1) && (aDrawer.counter == 0 || timeRemaining == 0) && (isGameOver == false)) {
            aDrawer.countdownTimer.invalidate()
            isGameOver = true
            moveToGameOver()
        }
        
        else if ((stage >= 2) && (aBlackboard.counter == 0 || aDrawer.counter == 0 || timeRemaining == 0) && (isGameOver == false)) {
            aDrawer.countdownTimer.invalidate()
            aBlackboard.countdownTimer.invalidate()
            isGameOver = true
            moveToGameOver()
        }
        
        else if ((stage >= 3) && (aWindow.timeRemaining == 0 || aBlackboard.counter == 0 || aDrawer.counter == 0 || timeRemaining == 0) && (isGameOver == false)) {
            aWindow.countdownTimer?.invalidate()
            aDrawer.countdownTimer.invalidate()
            aBlackboard.countdownTimer.invalidate()
            isGameOver = true
            moveToGameOver()
        }
        
    }
    
    // Next
    func nextQuestion() {
        changeQuestions()
        nextQ = false
    }
    
    func changeZPositions() {
        
        if examOpen {
            aExam.spriteNode.zPosition = 3.0
            aExam.exitLabel.zPosition = 4.0
            aExamSheet.question.zPosition = 6.0
            aExamSheet.spriteNode.zPosition = 5.0
            aExamSheet.labelAnswerA.zPosition = 6.0
            aExamSheet.labelAnswerB.zPosition = 6.0
            aExamSheet.labelAnswerC.zPosition = 6.0
            aExamSheet.labelAnswerD.zPosition = 6.0
            aExamSheet.nextQuestion.zPosition = 6.0
            aExamSheet.prevQuestion.zPosition = 6.0
            if (stage >= 2) {
                aBlackboard.soundEnabled = true
            }
        }
        
        else if !examOpen {
            aExam.spriteNode.zPosition = -2.0
            aExam.exitLabel.zPosition = -1.0
            aExamSheet.question.zPosition = -1.0
            aExamSheet.spriteNode.zPosition = -2.0
            aExamSheet.labelAnswerA.zPosition = -1.0
            aExamSheet.labelAnswerB.zPosition = -1.0
            aExamSheet.labelAnswerC.zPosition = -1.0
            aExamSheet.labelAnswerD.zPosition = -1.0
            aExamSheet.nextQuestion.zPosition = -1.0
            aExamSheet.prevQuestion.zPosition = -1.0
            if (stage >= 2) {
                aBlackboard.soundEnabled = false
            }
        }
        
    }
    
    override func didMove(to view: SKView) {
        
        currentQuestionsAndAnswers.stage = stage
        
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
        globalTimerLabel.position = CGPoint(x: frame.minX+100, y: frame.maxY-100)
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
        
        // Exam Sheet Interactions
//        aExamSheet = ExamSheetScene(scene: self)
//        examSheetNode = ExamSheetItem(scene: self)
//        aExamSheet.spriteNode = examSheetNode
//        aExamSheet.spriteNode.zPosition = -1.0
        
        darkOverlay = SKSpriteNode(color: .black, size: self.size)
        darkOverlay.position = CGPoint(x: frame.midX, y: frame.midY)
        darkOverlay.size = CGSize(width: frame.width, height: frame.height)
        addChild(darkOverlay)
        
        darkOverlay.alpha = 0
        darkOverlay.zPosition = 20.0
        
        if (stage >= 1) {
            
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
                
                aBlackboard = BlackboardScene(scene: self)
                blackboardNode = BlackboardItem(scene: self)
                aBlackboard.spriteNode = blackboardNode
                // Timer label blackboard
                timerBlackboard.position = CGPoint(x: 0,y: 100)
                addChild(timerBlackboard)
                aBlackboard.timerBlackboard = timerBlackboard
                // Start the blackboard countdown
                aBlackboard.startCountdown()
                
                if (stage >= 3) {
                    
                    aWindow = WindowScene(scene: self)
                    windowNode = WindowItem(scene: self)
                    aWindow.spriteNode = windowNode
                    // Timer label window
                    aWindow.timerLabel = SKLabelNode(text: "\(Int(aWindow.timeRemaining))")
                    aWindow.timerLabel.position = CGPoint(x: frame.midX, y: frame.midY)
                    addChild(aWindow.timerLabel)
                    // Start the window countdown timer
                    aWindow.startCountdown()
                    
                }
                
                
            }
            
        }
        
    }
    
    @objc func updateFontSize() {
        if currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] == "A"
        {
            aExamSheet.labelAnswerA.fontSize = 100
            aExamSheet.labelAnswerB.fontSize = 50
            aExamSheet.labelAnswerC.fontSize = 50
            aExamSheet.labelAnswerD.fontSize = 50
        } else if currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] == "B"
        {
            aExamSheet.labelAnswerA.fontSize = 50
            aExamSheet.labelAnswerB.fontSize = 100
            aExamSheet.labelAnswerC.fontSize = 50
            aExamSheet.labelAnswerD.fontSize = 50
        } else if currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] == "C"
        {
            aExamSheet.labelAnswerA.fontSize = 50
            aExamSheet.labelAnswerB.fontSize = 50
            aExamSheet.labelAnswerC.fontSize = 100
            aExamSheet.labelAnswerD.fontSize = 50
        } else if currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] == "D"
        {
            aExamSheet.labelAnswerA.fontSize = 50
            aExamSheet.labelAnswerB.fontSize = 50
            aExamSheet.labelAnswerC.fontSize = 50
            aExamSheet.labelAnswerD.fontSize = 100
        }
    }
    
    // Change Questions
    @objc func changeQuestions() {
        
        aExamSheet = ExamSheetScene(scene: self)
        examSheetNode = ExamSheetItem(scene: self)
        
        let labelQuestion = currentQuestionsAndAnswers.qACA[currentQuestionsAndAnswers.qACA.index(currentQuestionsAndAnswers.qACA.startIndex, offsetBy: questionNumber-1)].questions
        aExamSheet.question = SKLabelNode(text: "\(labelQuestion)")
        
        aExamSheet.question.fontSize = 50
        aExamSheet.question.fontColor = .black
        
        var labelAnswer =
        currentQuestionsAndAnswers.qACA[currentQuestionsAndAnswers.qACA.index(currentQuestionsAndAnswers.qACA.startIndex, offsetBy: questionNumber-1)].answerA
        aExamSheet.labelAnswerA = SKLabelNode(text: "\(labelAnswer)")
        
        var answered = currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)]
        if answered == "A" {
            aExamSheet.labelAnswerA.fontSize = 100
        } else {
            aExamSheet.labelAnswerA.fontSize = 50
        }
        
        labelAnswer =
        currentQuestionsAndAnswers.qACA[currentQuestionsAndAnswers.qACA.index(currentQuestionsAndAnswers.qACA.startIndex, offsetBy: questionNumber-1)].answerB
        aExamSheet.labelAnswerB = SKLabelNode(text: "\(labelAnswer)")
        answered = currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)]
        if answered == "B" {
            aExamSheet.labelAnswerB.fontSize = 100
        } else {
            aExamSheet.labelAnswerB.fontSize = 50
        }
        
        labelAnswer =
        currentQuestionsAndAnswers.qACA[currentQuestionsAndAnswers.qACA.index(currentQuestionsAndAnswers.qACA.startIndex, offsetBy: questionNumber-1)].answerC
        aExamSheet.labelAnswerC = SKLabelNode(text: "\(labelAnswer)")
        answered = currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)]
        if answered == "C" {
            aExamSheet.labelAnswerC.fontSize = 100
        } else {
            aExamSheet.labelAnswerC.fontSize = 50
        }
        
        labelAnswer =
        currentQuestionsAndAnswers.qACA[currentQuestionsAndAnswers.qACA.index(currentQuestionsAndAnswers.qACA.startIndex, offsetBy: questionNumber-1)].answerD
        aExamSheet.labelAnswerD = SKLabelNode(text: "\(labelAnswer)")
        answered = currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)]
        if answered == "D" {
            aExamSheet.labelAnswerD.fontSize = 100
        } else {
            aExamSheet.labelAnswerD.fontSize = 50
        }
        
        aExamSheet.nextQuestion = SKLabelNode(text: "next")
        aExamSheet.nextQuestion.fontSize = 100
        aExamSheet.nextQuestion.fontColor = .black
        aExamSheet.nextQuestion.position = CGPoint(x: self.frame.midX+10, y: self.frame.midY)
    
        aExamSheet.prevQuestion = SKLabelNode(text: "prev")
        aExamSheet.prevQuestion.fontSize = 100
        aExamSheet.prevQuestion.fontColor = .black
        aExamSheet.prevQuestion.position = CGPoint(x: self.frame.midX-10, y: self.frame.midY)
        
        aExamSheet.question.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        aExamSheet.labelAnswerA.position = CGPoint(x: frame.midX-100, y: frame.midY - 100)
        aExamSheet.labelAnswerB.position = CGPoint(x: frame.midX+100, y: frame.midY - 100)
        aExamSheet.labelAnswerC.position = CGPoint(x: frame.midX-100, y: frame.midY - 200)
        aExamSheet.labelAnswerD.position = CGPoint(x: frame.midX+100, y: frame.midY - 200)
        
        aExamSheet.labelAnswerA.fontColor = .black
        aExamSheet.labelAnswerB.fontColor = .black
        aExamSheet.labelAnswerC.fontColor = .black
        aExamSheet.labelAnswerD.fontColor = .black
        aExamSheet.spriteNode = examSheetNode
        
        if (firstTime) {
            addChild(aExamSheet.question)
            addChild(aExamSheet.labelAnswerA)
            addChild(aExamSheet.labelAnswerB)
            addChild(aExamSheet.labelAnswerC)
            addChild(aExamSheet.labelAnswerD)
            if (questionNumber > 1) {
                addChild(aExamSheet.prevQuestion)
            }
            if (questionNumber < 1) {
                addChild(aExamSheet.nextQuestion)
            }
            firstTime = false
        } else if (!firstTime) {
            aExamSheet.spriteNode.removeFromParent()
            aExamSheet.question.removeFromParent()
            aExamSheet.labelAnswerA.removeFromParent()
            aExamSheet.labelAnswerB.removeFromParent()
            aExamSheet.labelAnswerC.removeFromParent()
            aExamSheet.labelAnswerD.removeFromParent()
            if (questionNumber > 1) {
                aExamSheet.prevQuestion.removeFromParent()
            }
            if (questionNumber < 10) {
                aExamSheet.nextQuestion.removeFromParent()
            }
            addChild(aExamSheet.question)
            addChild(aExamSheet.labelAnswerA)
            addChild(aExamSheet.labelAnswerB)
            addChild(aExamSheet.labelAnswerC)
            addChild(aExamSheet.labelAnswerD)
            if (questionNumber > 1) {
                
                addChild(aExamSheet.prevQuestion)
            }
            if (questionNumber < 10) {
                
                addChild(aExamSheet.nextQuestion)
            }
        }
        
    }
    
    // Dark Overlay
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
        let scene = GameScene()
        scene.stage = stage+1
        scene.position = CGPoint(x: 0, y: 0)
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
        
        // Began for window
        if (isHeld == false && !examOpen) {
            
            if (aExamTable.spriteNode.contains(touchLocation)) {
                examOpen.toggle()
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
            
        }
        
        else if examOpen {
            
            if (aExam.exitLabel.contains(touchLocation)) {
                examOpen.toggle()
            } else if (aExamSheet.labelAnswerA.contains(touchLocation)) {
                currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] = "A"
                updateFontSize()
                
            } else if (aExamSheet.labelAnswerB.contains(touchLocation)) {
                currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] = "B"
                updateFontSize()
            } else if (aExamSheet.labelAnswerC.contains(touchLocation)) {
                currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] = "C"
                updateFontSize()
            } else if (aExamSheet.labelAnswerD.contains(touchLocation)) {
                currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] = "D"
                updateFontSize()
            } else if (questionNumber < 10) {
                if (aExamSheet.nextQuestion.contains(touchLocation)) {
                    questionNumber += 1
                    nextQ = true
                }
            } else if (questionNumber > 1) {
                if (aExamSheet.prevQuestion.contains(touchLocation)) {
                    questionNumber -= 1
                    nextQ = true
                }
            }
        
            print(currentQuestionsAndAnswers.playerAnswers)
            
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

