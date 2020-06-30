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
    public var bagView: MochilaView?
    public var aberto = false
    public let bag = UIButton()
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
        
        bag.frame = CGRect(x: self.view.frame.width - 40, y: (self.view.frame.height/2) - 33, width: 40, height: 67)
        bag.addTarget(nil, action: #selector (tapBagButton), for: .touchUpInside)
        bag.setImage(UIImage(named: "botaoAbrir.png"), for: .normal)
        
        
        bagView = MochilaView(frame: CGRect(x: 596, y: 0, width: 300, height: self.view.frame.height))
        bagView!.isHidden = true
        
        let pauseButtonIm = "pause.png"
        let pauseButtonImage = UIImage(named: pauseButtonIm)
        let pauseButton = UIButton(frame: CGRect(x: 27, y: 23, width: 15, height: 19))
        pauseButton.addTarget(nil, action: #selector (tapPauseButton), for: .touchUpInside)
        pauseButton.setImage(pauseButtonImage, for: .normal)
        
        view.addSubview(pauseButton)
        self.view.addSubview(pauseView!)
        self.view.addSubview(bag)
        self.view.addSubview(bagView!)
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
    
    @objc func tapBagButton(){
        if aberto == false {
            bagView!.isHidden = false
            bag.frame = CGRect(x: self.view.frame.width - 340, y: (self.view.frame.height/2) - 33, width: 40, height: 67)
            bag.setImage(UIImage(named: "botaoFechar.png"), for: .normal)
            aberto = true
            
            self.scene?.isUserInteractionEnabled = false
            self.bagView?.isUserInteractionEnabled = true
        }
        else {
            bagView!.isHidden = true
            bag.frame = CGRect(x: self.view.frame.width - 40, y: (self.view.frame.height/2) - 33, width: 40, height: 67)
            bag.setImage(UIImage(named: "botaoAbrir.png"), for: .normal)
            aberto = false
            
            self.scene?.isUserInteractionEnabled = true
            self.bagView?.isUserInteractionEnabled = false
        }

    }
    
    @objc func tapPauseButton() {
        self.scene?.isUserInteractionEnabled = false
        self.pauseView!.isHidden = false
    }
}
