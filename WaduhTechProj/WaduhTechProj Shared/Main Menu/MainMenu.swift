//
//  MainMenu.swift
//  WaduhTechProj iOS
//
//  Created by Abiyyu Firmansyah on 25/06/23.
//

import Foundation
import SpriteKit
import AVFoundation

class MainMenu: SKScene {
    
    var stage: Int = 0
    
    var newGame: SKSpriteNode!
    var continueButton: SKSpriteNode!
    var startLocation: CGPoint? = nil
    var audioPlayer: AVAudioPlayer! // Add this line

    func playMusic() {
        let path = Bundle.main.path(forResource: "mainmenu", ofType: "wav")
        let fileURL = URL(fileURLWithPath: path!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
        } catch {
            print("error play music")
        }
        audioPlayer.numberOfLoops = -1 //Infinite
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    override func didMove(to view: SKView) {
        playMusic()
        
        // MARK: Button New Game
        newGame = SKSpriteNode(imageNamed: "newButton")
        newGame.zPosition = 2
        newGame.position = CGPoint(x: 0, y: -100)
        newGame.size = CGSize(width: 485, height: 100)
        addChild(newGame)
        
        if (stage >= 1) {
            // MARK: Button Continue
            continueButton = SKSpriteNode(imageNamed: "continueButton")
            continueButton.zPosition = 2
            continueButton.position = CGPoint(x: 0, y: -250)
            continueButton.size = CGSize(width: 485, height: 100)
            addChild(continueButton)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let transition = SKTransition.fade(with: .black, duration: 5)
            
            if newGame.contains(location) {
                let scene = ExamTransition()
                scene.stage = 1
                scene.size = CGSize(width: frame.width, height: frame.height)
                self.view?.presentScene(scene, transition: transition)
            }
            else if stage > 1 && continueButton.contains(location) {
                if (stage >= 1) {
                    
                    let scene = ExamTransition()
                    scene.stage = stage
                    scene.size = CGSize(width: frame.width, height: frame.height)
                    self.view?.presentScene(scene, transition: transition)
                }
                
            }
        }
    }
}
