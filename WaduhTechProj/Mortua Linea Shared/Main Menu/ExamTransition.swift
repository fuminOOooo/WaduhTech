//
//  ExamTransition.swift
//  WaduhTechProj iOS
//
//  Created by Elvis Susanto on 26/06/23.
//

import Foundation
import SpriteKit
import AVFoundation

class ExamTransition: SKScene {
    var stage: Int = 0
    var timer = Timer()
    var gesture = ""
    var audioPlayer: AVAudioPlayer! // Add this line

    func playMusic() {
        let path = Bundle.main.path(forResource: "bellRing_5s", ofType: "wav")
        let fileURL = URL(fileURLWithPath: path!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
        } catch {
            print("error play music")
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    override func didMove(to view: SKView) {
        playMusic()
        let background = SKSpriteNode()
        background.color = .black
        background.size = CGSize(width: frame.width, height: frame.height)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        // MARK: To Define Gesture Available
        if (stage == 1) {
            gesture = "Swipe"
        } else if (stage == 2) {
            gesture = "Swipe 2"
        } else if (stage == 3) {
            gesture = "Hold"
        } else if (stage == 4) {
            gesture = "All at once"
        }
        
        let examLabel = SKLabelNode(attributedText: NSAttributedString(string: "EXAM \(stage): \"\(gesture)\"", attributes: [.font: UIFont(name: "hulberthopperdisplay", size: 64)!, .foregroundColor: UIColor.white]))
        
        examLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(examLabel)
        
        let durationLabel = SKLabelNode(attributedText: NSAttributedString(string: "17:00 - 19:00",
                                                                           attributes: [.font: UIFont.systemFont(ofSize: 48, weight: .light),
                                                                                        .foregroundColor: UIColor.white]))
        durationLabel.position = CGPoint(x: frame.midX, y: frame.midY-100)
        addChild(durationLabel)
        
        timer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(moveToExam), userInfo: nil, repeats: false)
        
    }
    
    @objc func moveToExam() {
        //Configure the new scene to be presented and then present.
        let scene = GameScene()
        scene.stage = stage
        scene.size = CGSize(width: frame.width, height: frame.height)
        self.view?.presentScene(scene)
        
    }
    
    deinit {
        //Stops the timer.
        timer.invalidate()
    }
    
}
