//
//  GameViewController.swift
//  Project29GunboundLikeGame
//
//  Created by Ana Caroline de Souza on 26/03/20.
//  Copyright © 2020 Ana e Leo Corp. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var currentGame: GameScene!

    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var angleLabel: UILabel!
    @IBOutlet var gravityLabel: UILabel!
    
    @IBOutlet var velocitySlider: UISlider!
    @IBOutlet var velocityLabel: UILabel!
    @IBOutlet var launchButton: UIButton!
    @IBOutlet var playerNumber: UILabel!
    @IBOutlet var player1ScoreLabel: UILabel!
    @IBOutlet var player2ScoreLabel: UILabel!
    
    var player1Score = 0 {
        didSet {
            player1ScoreLabel.text = " Player 1 Score: \(player1Score)"
        }
    }
    var player2Score = 0{
        didSet {
            player2ScoreLabel.text = " Player 2 Score: \(player2Score)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame?.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        angleChanged(self)
        velocityChanged(self)
        createWind()
        
    }
    
    func createWind(){
        
        let direction = Int.random(in: -1...1)
        let gravityStrength = Int.random(in: 6...12)
        var gravityLabelText = ""
        
        currentGame.physicsWorld.gravity = CGVector(dx: direction, dy: gravityStrength)
        
        if direction == 1 {
            gravityLabelText += "Right"
        } else {
            gravityLabelText += "Gravity: Left[\(gravityStrength)]"
        }
        
        gravityLabel.text = gravityLabelText
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBAction func angleChanged(_ sender: Any) {
        
        angleLabel.text = "Angle: \(Int(angleSlider.value))°"
    
    }
    
    @IBAction func velocityChanged(_ sender: Any) {
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    
    @IBAction func launch(_ sender: Any) {
        
        angleSlider.isHidden = true
        angleLabel.isHidden = true

        velocitySlider.isHidden = true
        velocityLabel.isHidden = true

        launchButton.isHidden = true

        currentGame.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
        
    }
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
        } else {
            playerNumber.text = "PLAYER TWO >>>"
        }

        angleSlider.isHidden = false
        angleLabel.isHidden = false

        velocitySlider.isHidden = false
        velocityLabel.isHidden = false

        launchButton.isHidden = false
    }
    
    
    
}
