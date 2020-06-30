//
//  playerStateMachine.swift
//  Outer Space
//
//  Created by Matheus Andrade on 07/06/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//

import GameplayKit

fileprivate let characterAnimationKey = "Sprite Animation"

class PlayerState: GKState {
    unowned var playerNode: SKNode

    init(playerNode : SKNode){
        self.playerNode = playerNode

        super.init()
    }
}

class JumpingState : PlayerState {
    
    var hasFinishedJumping : Bool = false
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        if hasFinishedJumping{
            return true
        }
        
        return false
    }

    
    let textures : Array<SKTexture> = (0..<4).map({ return "jump/\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.animate(with: textures, timePerFrame: 0.1)} ()

    override func didEnter(from previousState: GKState?) {
        
        if let topMostViewController = UIApplication.shared.topMostViewController() as? GameViewController{
            
            topMostViewController.scene?.shadow?.alpha = 0
        }
        
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
        
        hasFinishedJumping = false
        playerNode.run(.applyForce(CGVector(dx: 0, dy: 68), duration: 0.4))

        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) {(timer) in
            self.hasFinishedJumping = true
            self.stateMachine?.enter(LandingState.self)
            
        }
    }
    
}

class LandingState : PlayerState {
    var hasFinishedLanding: Bool = false
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if hasFinishedLanding{
            return true
        }
        return false
        
    }
    
    let textures : Array<SKTexture> = (0..<4).map({ return "jump/\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.animate(with: textures.reversed(), timePerFrame: 0.1)} ()
    
    override func didEnter(from previousState: GKState?) {
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
        
        //Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) {(timer) in
            self.hasFinishedLanding = true
            self.stateMachine?.enter(IdleState.self)
            
        //}
        
        
    }
}

class IdleState : PlayerState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {

        switch stateClass {
        case is LandingState.Type, is IdleState.Type: return false
        default: return true
        }
    }

    let textures = SKTexture(imageNamed: "playerIdle")
    lazy var action = { SKAction.animate(with: [textures], timePerFrame: 0.1)} ()

    override func didEnter(from previousState: GKState?) {

        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
    }
}

class WalkingState : PlayerState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {

        switch stateClass {
        case is LandingState.Type, is WalkingState.Type : return false
        default: return true
        }
    }

    let textures : Array<SKTexture> = (0..<6).map({ return "player/\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.1))} ()

    override func didEnter(from previousState: GKState?) {

        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
    }
}

class StunnedState : PlayerState {
    
}
