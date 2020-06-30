//
//  GameViewController.swift
//  Outer Space
//
//  Created by Matheus Andrade on 07/06/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var pauseView: PauseView?
    
    var scene: SKScene?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pauseView = PauseView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        pauseView!.isHidden = true
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            scene = SKScene(fileNamed: "GameScene")
            
            if scene != nil {
                // Set the scale mode to scale to fit the window
                scene!.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = false
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
        
        let pauseButtonIm = "pause.png"
        let pauseButtonImage = UIImage(named: pauseButtonIm)
        let pauseButton = UIButton(frame: CGRect(x: 27, y: 23, width: 15, height: 19))
        pauseButton.addTarget(nil, action: #selector (tapPauseButton), for: .touchUpInside)
        pauseButton.setImage(pauseButtonImage, for: .normal)
        
        view.addSubview(pauseButton)
        self.view.addSubview(pauseView!)
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
    
    @objc func tapPauseButton() {
        self.scene?.isUserInteractionEnabled = false
        self.pauseView!.isHidden = false
    }
}
