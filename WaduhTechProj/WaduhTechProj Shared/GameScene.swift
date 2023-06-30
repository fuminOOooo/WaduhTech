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
    var done: Bool = false
    
    var loseIndicator: Int = 0
    // 1 = Ran out of global timer
    // 2 = Failed to maintain obstacle
    // 3 = Failed to reach minimum score
    
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
                            aLaci.enableSoundEffects()
                            if stage >= 4 {
                                aTV.enableSoundEffects()
                            }
                        }
                    }
                }
                
            }
            
            if !examOpen {
                
                // Turn off sound effects
                if stage >= 1 {
                    aDrawer.disableSoundEffects()
                    if stage >= 2 {
                        aBlackboard.disableSoundEffects()
                        aWindow.disableSoundEffects()
                        if stage >= 3 {
                            aLaci.disableSoundEffects()
                            if stage >= 4 {
                                aTV.disableSoundEffects()
                            }
                        }
                    }
                }
                
            }
            
            changeZPositions()
            
        }
        
    }
    var buttonTest: SKLabelNode!
    
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
    var bgTexture: SKTexture = SKTexture(imageNamed: "classroomBG")
    
    // Blackboard
    var blackboardNode: BlackboardItem!
    var aBlackboard: BlackboardScene!
    
    // Light Switch
    var lightSwitchNode: LightSwitchItem!
    var aLightSwitch: LightSwitchScene!
    
    // Cupboard
    var drawerNode: DrawerItem!
    var aDrawer: DrawerScene!
    
    // Window
    var windowNode: WindowItem!
    var aWindow: WindowScene!
    
    // Drawer
    var laciNode: LaciItem!
    var aLaci: LaciScene!
    
    // TV
    var tvNode: TVItem!
    var aTV: TVScene!
    
    // Left Chair
    var leftChairNode: LeftChairItem!
    var aLeftChair: LeftChairScene!
    
    // Right Chair
    var rightChairNode: RightChairItem!
    var aRightChair: RightChairScene!
    
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
    
    var timeRemaining: TimeInterval = 120.0
    var totalDuration: TimeInterval = 120.0
    var globalTimerLabel: SKLabelNode!
    var darkOverlay: SKSpriteNode!
    var lightSwitch: Bool = false
    var leftChairFix: Bool = false
    
    var nextLight: TimeInterval = 0.0
    
    var firstTime: Bool = true
    
    func lightsTurning() {
        if lightSwitch == true {
            darkOverlay.alpha = 0.0
            nextLight = TimeInterval(Int.random(in: 12...15))
            lightSwitch = false
            let texture = SKTexture(imageNamed: "onSwitch")
            let textureAction = SKAction.setTexture(texture)
            aLightSwitch.spriteNode.run(textureAction)
        } else if nextLight == 0 {
            if (examOpen) {
                let windowOpenSound = SKAction.playSoundFileNamed("lightswitch3_off", waitForCompletion: false)
                self.run(windowOpenSound)
            }
            let texture = SKTexture(imageNamed: "offSwitch")
            let textureAction = SKAction.setTexture(texture)
            aLightSwitch.spriteNode.run(textureAction)
        }
            
    }

    override func update(_ currentTime: TimeInterval) {
        
        lightsTurning()
        
        if nextLight == 0 {
            darken()
        }
        
        if (done == false) {
            checkAnswers()
        }
        
        checkAnswers()
        
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
        
        else if ((stage >= 4) && (aBlackboard.counter == 0 || aDrawer.counter == 0 || aWindow.counter == 0 || aLaci.timeRemaining == 0 || aTV.timeRemaining == 0 || timeRemaining == 0 || aLeftChair.counter == 0 || aRightChair.counter == 0) && (isGameOver == false)) {
            // TODO: Drawer, blackboard, window, all item that use hold gesture
            aDrawer.countdownTimer.invalidate()
            aBlackboard.countdownTimer.invalidate()
            aWindow.countdownTimer.invalidate()
            aLaci.countdownTimer?.invalidate()
            aTV.countdownTimer?.invalidate()
            aLeftChair.countdownTimer.invalidate()
            aRightChair.countdownTimer.invalidate()
            isGameOver = true
            moveToGameOver()
        }
        
    }
    
    // MARK: Changing ZPosition of Exam
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
//                aBlackboard.soundEnabled = false
            }
        }
        
    }
    
    override func didMove(to view: SKView) {
        
        currentQuestionsAndAnswers.stage = stage
        
        // Global Timer
        globalTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            if timeRemaining > 0 {
                timeRemaining -= 1.0
            }
            if nextLight > 0 {
                nextLight -= 1.0
            }
        }
        
        // Background
        bg = SKSpriteNode(texture: bgTexture)
        bg.position = CGPoint(x: frame.midX, y: frame.midY)
        bg.size = CGSize(width: frame.width, height: frame.height)
        addChild(bg)
        bg.zPosition = -0.0
        
        // Global Timer Label
        globalTimerLabel = SKLabelNode(text: "\(Int(timeRemaining))")
        globalTimerLabel.position = CGPoint(x: frame.minX+100, y: frame.maxY-100)
        globalTimerLabel.fontColor = .black
        globalTimerLabel.zPosition = 6
        addChild(globalTimerLabel)
        
        // First Person Exam Table
        aExam = ExamScene(scene: self)
        examNode = ExamItem(scene: self)
        aExam.spriteNode = examNode
        aExam.exitLabel = SKSpriteNode(imageNamed: "examPaper")
        aExam.exitLabel.position = CGPoint(x: frame.maxX-200, y: frame.maxY-200)
        aExam.exitLabel.size = CGSize(width: 30, height: 30)
        addChild(aExam.exitLabel)
        aExam.exitLabel.zPosition = -1.0
        
        // Opening Exam
        aExamTable = ExamTableScene(scene: self)
        examTableNode = ExamTableItem(scene: self)
        aExamTable.spriteNode = examTableNode
        
        // Opening Exam
        aLightSwitch = LightSwitchScene(scene: self)
        lightSwitchNode = LightSwitchItem(scene: self)
        aLightSwitch.spriteNode = lightSwitchNode
        aLightSwitch.spriteNode.zPosition = 1.0
        
        // Exam Sheet
        aExamSheet = ExamSheetScene(scene: self)
        examSheetNode = ExamSheetItem(scene: self)
        aExamSheet.question = SKLabelNode(text: "")
        aExamSheet.nextQuestion = SKLabelNode(text: "")
        aExamSheet.prevQuestion = SKLabelNode(text: "")
        aExamSheet.labelAnswerA = SKLabelNode(text: "")
        aExamSheet.labelAnswerB = SKLabelNode(text: "")
        aExamSheet.labelAnswerC = SKLabelNode(text: "")
        aExamSheet.labelAnswerD = SKLabelNode(text: "")
        changeQuestions()
        aExamSheet.spriteNode = examSheetNode
        examSheetNode.addChild(aExamSheet.question)
        examSheetNode.addChild(aExamSheet.labelAnswerA)
        examSheetNode.addChild(aExamSheet.labelAnswerB)
        examSheetNode.addChild(aExamSheet.labelAnswerC)
        examSheetNode.addChild(aExamSheet.labelAnswerD)
        examSheetNode.addChild(aExamSheet.prevQuestion)
        examSheetNode.addChild(aExamSheet.nextQuestion)
        changeZPositions()
        
        
        // Exam Sheet Interactions
//        aExamSheet = ExamSheetScene(scene: self)
//        examSheetNode = ExamSheetItem(scene: self)
//        aExamSheet.spriteNode = examSheetNode
//        aExamSheet.spriteNode.zPosition = -1.0
        
        // Lights Out
        darkOverlay = SKSpriteNode(color: .black, size: self.size)
        darkOverlay.position = CGPoint(x: frame.midX, y: frame.midY)
        darkOverlay.size = CGSize(width: frame.width, height: frame.height)
        addChild(darkOverlay)
        
        darkOverlay.alpha = 0
        darkOverlay.zPosition = 20.0
        
        // MARK: BUTTON BUAT TEST WIN CONDITION
        buttonTest = SKLabelNode(text: "SUBMIT")
        buttonTest.fontSize = 100
        buttonTest.position = CGPoint(x: frame.midX-420, y: frame.midY-430)
        addChild(buttonTest)
        buttonTest.zPosition = -2.0
        
        // MARK: Setup Stage Timer and Obstacle
        if (stage >= 1) {
            // MARK: Cupboard Item
            timeRemaining = 240.0
            totalDuration = 240.0
            aDrawer = DrawerScene(scene: self)
            drawerNode = DrawerItem(scene: self)
            aDrawer.spriteNode = drawerNode
            
            // Start the drawer counter timer
            aDrawer.startCountdown()
            
            if (stage >= 2) {
                timeRemaining = 300.0
                totalDuration = 300.0
                
                // MARK: Blackboard Item
                aBlackboard = BlackboardScene(scene: self)
                blackboardNode = BlackboardItem(scene: self)
                aBlackboard.spriteNode = blackboardNode
                
                // Start the blackboard countdown
                aBlackboard.startCountdown()
                
                // MARK: Window Item
                aWindow = WindowScene(scene: self)
                windowNode = WindowItem(scene: self)
                aWindow.spriteNode = windowNode
                
                // Start the window countdown timer
                aWindow.startCountdown()
                
                if (stage >= 3) {
                    timeRemaining = 330.0
                    totalDuration = 330.0
                    
                    // MARK: Laci Item
                    aLaci = LaciScene(scene: self)
                    laciNode = LaciItem(scene: self)
                    aLaci.spriteNode = laciNode
                    //Start drawer countdown timer
                    aLaci.startCountdown()
                    
                    if (stage >= 4) {
                        timeRemaining = 360.0
                        totalDuration = 360.0
                        
                        // MARK: TV Item
                        aTV = TVScene(scene: self)
                        tvNode = TVItem(scene: self)
                        aTV.spriteNode = tvNode
                        
                        //Start drawer countdown timer
                        aTV.startCountdown()
                        
                        // MARK: Left Chair Item
                        aLeftChair = LeftChairScene(scene: self)
                        leftChairNode = LeftChairItem(scene: self)
                        aLeftChair.spriteNode = leftChairNode
                        // Start left chair countdown timer
                        aLeftChair.startCountdown()
                        
                        //MARK: Right Chair Item
                        aRightChair = RightChairScene(scene: self)
                        rightChairNode = RightChairItem(scene: self)
                        aRightChair.spriteNode = rightChairNode
                        
                        aRightChair.startCountdown()
                    }
                }
            }
        }
    }
    
    
    // Change Questions
    func changeQuestions() {
        
        let labelQuestion = currentQuestionsAndAnswers.qACA[currentQuestionsAndAnswers.qACA.index(currentQuestionsAndAnswers.qACA.startIndex, offsetBy: questionNumber-1)].questions
        aExamSheet.question.text = "\(labelQuestion)"
        
        aExamSheet.question.fontSize = 40
        aExamSheet.question.fontColor = .black
        
        var labelAnswer =
        currentQuestionsAndAnswers.qACA[currentQuestionsAndAnswers.qACA.index(currentQuestionsAndAnswers.qACA.startIndex, offsetBy: questionNumber-1)].answerA
        aExamSheet.labelAnswerA.text = "\(labelAnswer)"
        
        var answered = currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)]
        if answered == "A" {
            aExamSheet.labelAnswerA.fontColor = .systemBlue
        } else {
            aExamSheet.labelAnswerA.fontColor = .black
        }
        
        labelAnswer =
        currentQuestionsAndAnswers.qACA[currentQuestionsAndAnswers.qACA.index(currentQuestionsAndAnswers.qACA.startIndex, offsetBy: questionNumber-1)].answerB
        aExamSheet.labelAnswerB.text = "\(labelAnswer)"
        answered = currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)]
        if answered == "B" {
            aExamSheet.labelAnswerB.fontColor = .systemBlue
        } else {
            aExamSheet.labelAnswerB.fontColor = .black
        }
        
        labelAnswer =
        currentQuestionsAndAnswers.qACA[currentQuestionsAndAnswers.qACA.index(currentQuestionsAndAnswers.qACA.startIndex, offsetBy: questionNumber-1)].answerC
        aExamSheet.labelAnswerC.text = "\(labelAnswer)"
        answered = currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)]
        if answered == "C" {
            aExamSheet.labelAnswerC.fontColor = .systemBlue
        } else {
            aExamSheet.labelAnswerC.fontColor = .black
        }
        
        labelAnswer =
        currentQuestionsAndAnswers.qACA[currentQuestionsAndAnswers.qACA.index(currentQuestionsAndAnswers.qACA.startIndex, offsetBy: questionNumber-1)].answerD
        aExamSheet.labelAnswerD.text = "\(labelAnswer)"
        answered = currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)]
        if answered == "D" {
            aExamSheet.labelAnswerD.fontColor = .systemBlue
        } else {
            aExamSheet.labelAnswerD.fontColor = .black
        }
        
        if (questionNumber < currentQuestionsAndAnswers.qACA.count) {
            aExamSheet.nextQuestion.text = "next"
            aExamSheet.nextQuestion.fontSize = 30
            aExamSheet.nextQuestion.fontColor = .black
            aExamSheet.nextQuestion.position = CGPoint(x: self.frame.midX+200, y: self.frame.midY+100)
        } else {
            aExamSheet.nextQuestion.text = ""
        }
        
        if (questionNumber > 1) {
            aExamSheet.prevQuestion.text = "prev"
            aExamSheet.prevQuestion.fontSize = 30
            aExamSheet.prevQuestion.fontColor = .black
            aExamSheet.prevQuestion.position = CGPoint(x: self.frame.midX-200, y: self.frame.midY+100)
        } else {
            aExamSheet.prevQuestion.text = ""
        }
        
        aExamSheet.question.position = CGPoint(x: aExamSheet.scene.frame.midX, y: aExamSheet.scene.frame.midY)
        
        aExamSheet.labelAnswerA.position = CGPoint(x: self.frame.midX-100, y: self.frame.midY-100)
        aExamSheet.labelAnswerB.position = CGPoint(x: self.frame.midX+100, y: self.frame.midY-100)
        aExamSheet.labelAnswerC.position = CGPoint(x: self.frame.midX-100, y: self.frame.midY-200)
        aExamSheet.labelAnswerD.position = CGPoint(x: self.frame.midX+100, y: self.frame.midY-200)
        
        aExamSheet.labelAnswerA.fontSize = 50
        aExamSheet.labelAnswerB.fontSize = 50
        aExamSheet.labelAnswerC.fontSize = 50
        aExamSheet.labelAnswerD.fontSize = 50
        
    }
    
    func nextStage() {
        let scene = ExamTransition()
        scene.stage = stage+1
        scene.size = CGSize(width: frame.width, height: frame.height)
        let transition = SKTransition.fade(with: .black, duration: 5)
        self.view?.presentScene(scene, transition: transition)
    }
    
    func checkCorrectAnswers() {
        var counter: Float = 0
        for i in 0 ..< currentQuestionsAndAnswers.correctAnswers.count-1 {
            if currentQuestionsAndAnswers.playerAnswers[i] == currentQuestionsAndAnswers.correctAnswers[i] {
                counter += 1
            }
        }
        if (currentQuestionsAndAnswers.correctAnswers.count == 5) {
            if (counter / 5 >= 0.8) {
                nextStage()
            } else {
                loseIndicator = 3
                moveToGameOver2()
            }
        }
        if (currentQuestionsAndAnswers.correctAnswers.count == 10) {
            if (counter / 10 >= 0.8) {
                nextStage()
            } else {
                loseIndicator = 3
                moveToGameOver2()
            }
        }
        
    }
    
    func checkAnswers() {
        var counter = 0
        for string in currentQuestionsAndAnswers.playerAnswers {
            if string.contains("-") {
                counter += 1
            }
        }
        if counter == 0 {
            buttonTest.zPosition = 1.0
            done = true
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
    
    // Khusus Drawer
    @objc func fireTimer() {
        print("Timer fired!")
        if aLaci.timeRemaining == 24 {
            aLaci.timeRemaining = 24
        } else if aLaci.timeRemaining < 24 {
            aLaci.timeRemaining += 1
        }
    }
    
    // Khusus TV
    @objc func fireTimerTV() {
        print("Timer fired!")
        if aTV.timeRemaining == 30 {
            aTV.timeRemaining = 30
        } else if aTV.timeRemaining < 30 {
            aTV.timeRemaining += 1
        }
    }
    
    @objc func moveToGameOver2() {
        if (stage >= 2) {
            let scene = GameOver()
            scene.stage = stage
            scene.loseIndicator = 3
            scene.size = CGSize(width: frame.width, height: frame.height)
            self.view?.presentScene(scene)
        }
        else if (stage == 1) {
            let scene = GameOverTransition()
            scene.stage = stage
            scene.loseIndicator = 3
            scene.size = CGSize(width: frame.width, height: frame.height)
            self.view?.presentScene(scene)
        }
    }
    
    @objc func moveToGameOver() {
        gameOverIndicator()
        if (stage >= 2) {
            let scene = GameOver()
            scene.stage = stage
            scene.loseIndicator = loseIndicator
            scene.size = CGSize(width: frame.width, height: frame.height)
            self.view?.presentScene(scene)
        }
        else if (stage == 1) {
            let scene = GameOverTransition()
            scene.stage = stage
            scene.loseIndicator = loseIndicator
            scene.size = CGSize(width: frame.width, height: frame.height)
            self.view?.presentScene(scene)
        }
    }
    
    func gameOverIndicator() {
        if (timeRemaining == 0) {
            loseIndicator = 1
        } else if (aDrawer.counter == 0 || aBlackboard.counter == 0 || aWindow.counter == 0 || aLaci.timeRemaining == 0 || aTV.timeRemaining == 0 || aLeftChair.counter == 0 || aRightChair.counter == 0) {
            loseIndicator = 2
        }
    }
    
    // MARK: Touches Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
        if (isHeld == false && !examOpen) {
            
            // MARK: Began for Tap Gesture
            if (aExamTable.spriteNode.contains(touchLocation)) {
                examOpen.toggle()
            }
            
            else if (lightSwitch == false && aLightSwitch.spriteNode.contains(touchLocation)) {
                lightSwitch = true
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
            else if (leftChairNode != nil && leftChairNode.contains(touchLocation)) {
                leftChairNode.texture = SKTexture(imageNamed: "kursiTap1_1")
                print("left chair texture change")
                aLeftChair.startCountdown()
            }
            
            // MARK: Began for Hold Gesture
            
            else if (aLaci != nil && aLaci.spriteNode.contains(touchLocation)) {
                isHeld.toggle()
                whichTouchIndicator = 4
                
                print("touch inside laci detected!")
                
                aLaci.holdTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
                
                // Laci timer stops
                aLaci.countdownTimer?.invalidate()
                aLaci.countdownTimer = nil
                
                aLaci.touchStartTime = touch.timestamp
            }
            
            else if (aTV != nil && aTV.spriteNode.contains(touchLocation)) {
                isHeld.toggle()
                whichTouchIndicator = 5
                
                print("touch inside tv detected!")
                
                aTV.holdTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fireTimerTV), userInfo: nil, repeats: true)
                
                // Laci timer stops
                aTV.countdownTimer?.invalidate()
                aTV.countdownTimer = nil
                
                aTV.touchStartTime = touch.timestamp
            }
            else if (done == true && buttonTest != nil && buttonTest.contains(touchLocation)) {
                isHeld.toggle()
                checkCorrectAnswers()
            }
            
        } else if examOpen {
            
            if (aExam.exitLabel.contains(touchLocation)) {
                examOpen.toggle()
            }
            else if (aExamSheet.spriteNode.contains(touchLocation)) {
                if (aExamSheet.labelAnswerA.contains(touchLocation)) {
                    currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] = "A"
                } else if (aExamSheet.labelAnswerB.contains(touchLocation)) {
                    currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] = "B"
                } else if (aExamSheet.labelAnswerC.contains(touchLocation)) {
                    currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] = "C"
                } else if (aExamSheet.labelAnswerD.contains(touchLocation)) {
                    currentQuestionsAndAnswers.playerAnswers[currentQuestionsAndAnswers.playerAnswers.index(currentQuestionsAndAnswers.playerAnswers.startIndex, offsetBy: questionNumber-1)] = "D"
                }
                if (questionNumber != 10) {
                    if (aExamSheet.nextQuestion.contains(touchLocation)) {
                        questionNumber += 1
                    }
                }
                if (questionNumber != 1) {
                    if (aExamSheet.prevQuestion.contains(touchLocation)) {
                        questionNumber -= 1
                    }
                }
                changeQuestions()
            }
            
            print(currentQuestionsAndAnswers.playerAnswers)
            
        }
        
    }
    
    // MARK: Touches Ended
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
                                windowNode.texture = SKTexture(imageNamed: "windowState1")
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
            else if (whichTouchIndicator == 5 && isHeld == true) {
                print("hold ended!")
                isHeld.toggle()
                aTV.holdTimer?.invalidate()
                aTV.holdTimer = nil
                
                aTV.startCountdown()
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

