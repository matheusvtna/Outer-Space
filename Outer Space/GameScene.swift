//
//  GameScene.swift
//  Outer Space
//
//  Created by Matheus Andrade on 07/06/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
 
    // Nodes
    var player: SKNode?
    var shadow : SKNode?
    var joystick: SKNode?
    var joystickKnob: SKNode?
    var cameraNode : SKCameraNode?
    var mountain1 : SKNode?
    var portal: SKNode?
    var artifact: SKNode?
    
    // Joystick
    var joystickAction = false
    var knobRadius: CGFloat = 50.0
    
    // Animation
    var previousTimeInterval: TimeInterval = 0
    var playerIsFacingRight = true
    let playerSpeed = 3.0
    var playerStateMachine : GKStateMachine!
    
    var messages: [Message] = []
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        player = childNode(withName: "player")
        shadow = childNode(withName: "shadow")
        joystick = childNode(withName: "joystick")
        joystickKnob = joystick?.childNode(withName: "knob")
        cameraNode = childNode(withName:  "cameraNode") as? SKCameraNode
        mountain1 = childNode(withName: "camadas")
        portal = childNode(withName: "portal")
        artifact = childNode(withName: "artifact1")
        
        playerStateMachine = GKStateMachine(states: [
        JumpingState(playerNode: player!),
        WalkingState(playerNode: player!),
        IdleState(playerNode: player!),
        LandingState(playerNode: player!),
        StunnedState(playerNode: player!),
        ])
        
        messages = [
            Message(text: "use o joystick para se movimentar", position: CGPoint(x: -530, y: frame.midY), condition: {(self.player?.position.x)! >= -1000}),
            Message(text: "toque na tela para pular com o jetpack", position: CGPoint(x: -120, y: frame.midY + 20), condition: {(self.player?.position.x)! >= -300}),
            Message(text: "o que será isso? toque para coletá-lo.", position: CGPoint(x: 180, y: frame.midY + 60), condition: {(self.player?.position.x)! >= 60}),
            Message(text: "se precisar ver seus itens, aperte o botão na direita", position: CGPoint(x: 350, y: frame.midY + 90), condition: {(self.player?.position.x)! >= 300}),
            Message(text: "toque no portal para viajar", position: CGPoint(x: 700, y: frame.midY + 60), condition: {(self.player?.position.x)! >= 550})
            
        ]
 
        playerStateMachine.enter(IdleState.self)
        
        //let start = SKAction.move(to: CGPoint(x: -900, y: -100), duration: 0.0)
        //player?.run(start)
    }
    
}

extension GameScene{
    func checkPosition(node1: SKNode, node2: SKNode, distance: CGFloat)->Bool{
        if abs(node1.position.x - node2.position.x) > distance{
            return false
        }
        else if abs(node1.position.x + node1.frame.width - node2.frame.width - node2.position.x) > distance{
            return false
        }
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let joystickKnob = joystickKnob {
                let location = touch.location(in: joystick!)
                joystickAction = joystickKnob.frame.contains(location)
            }
            
            
            let location = touch.location(in: self)
            
            if (portal?.contains(location))! && checkPosition(node1: player!, node2: portal!,distance: 100){
                if let topMostViewController = UIApplication.shared.topMostViewController() as? GameViewController{
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TransportViewController") as! TransportViewController
                    topMostViewController.present(vc, animated: true)
                }
            }
            else if (artifact?.contains(location))! && checkPosition(node1: player!, node2: artifact!,distance: 40){
                if let topMostViewController = UIApplication.shared.topMostViewController() as? GameViewController{
                    let index = artifact?.name?.last?.wholeNumberValue ?? 0
                    topMostViewController.bank.artifacts[index].find()
                    artifact?.removeFromParent()
                }
            }
            else if !(joystick?.contains(location))! {
                playerStateMachine.enter(JumpingState.self)
            }
            
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard joystick != nil else { return }
        guard joystickKnob != nil else { return }

        if !joystickAction { return }
        
        for touch in touches {
            let position = touch.location(in: joystick!)

            let length = sqrt(pow(position.y, 2) + pow(position.x, 2))
            let angle = atan2(position.y, position.x)

            if knobRadius > length {
                joystickKnob!.position = position
            } else {
                joystickKnob!.position = CGPoint(x: cos(angle) * knobRadius, y: sin(angle) * knobRadius)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let xJoystickCoordinate = touch.location(in: joystick!).x
            let xLimit: CGFloat = 200.0
            if xJoystickCoordinate > -xLimit && xJoystickCoordinate < xLimit {
                resetKnobPosition()
            }
        }
    }

    func resetKnobPosition() {
        let initialPoint = CGPoint(x: 0, y: 0)
        let moveBack = SKAction.move(to: initialPoint, duration: 0.1)
        moveBack.timingMode = .linear
        joystickKnob?.run(moveBack)
        joystickAction = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - previousTimeInterval
        previousTimeInterval = currentTime
        
        // Camera position
        cameraNode?.position.x = player!.position.x
        
        // Joystick position
        var xPositionToView = CGFloat(0)
        var yPositionToView = CGFloat(0)

        if let view = self.view {
            xPositionToView = view.frame.width/3 + view.safeAreaInsets.left
            yPositionToView = view.frame.height/4 + view.safeAreaInsets.bottom
        }
        var index = 0
        
        for message in messages{
            
            //print(self.player?.position.x ?? "")
            if message.condition(){
                index += 1
                if !message.completion{
                    

                    message.label.alpha = 0.0
                    message.label.run(SKAction.fadeIn(withDuration: 2.0))
                    message.completion = true
                    message.label.text = message.text
                    message.label.position = message.position
                    addChild(message.label)
                    
                }
                else{
                    
                }
            }
        }
        if index > 1{
            messages[0].label.alpha = 1
            
            messages[0].label.run(SKAction.sequence([.fadeOut(withDuration: 2.0),.removeFromParent()]))
            
            messages.remove(at: 0)
            
        }
        
        joystick?.position.y = (cameraNode?.position.y)! - yPositionToView
        joystick?.position.x = (cameraNode?.position.x)! - xPositionToView
        
        // Player movement
        guard let joystickKnob = joystickKnob else { return }
        
        let xPosition = Double(joystickKnob.position.x)
        
        let positivePosition = xPosition < 0 ? -xPosition : xPosition

        if floor(positivePosition) != 0 {
            playerStateMachine.enter(WalkingState.self)
        } else {
            playerStateMachine.enter(IdleState.self)
        }
        
        let displacement = CGVector(dx: deltaTime * xPosition * playerSpeed, dy: 0)
        let move = SKAction.move(by: displacement, duration: 0)
        let faceAction : SKAction!
        let movingRight = xPosition > 0
        let movingLeft = xPosition < 0
        
        if movingLeft && playerIsFacingRight {
            playerIsFacingRight = false
            let faceMovement = SKAction.scaleX(to: -1, duration: 0.0)
            faceAction = SKAction.sequence([move, faceMovement])
        }
        else if movingRight && !playerIsFacingRight {
            playerIsFacingRight = true
            let faceMovement = SKAction.scaleX(to: 1, duration: 0.0)
            faceAction = SKAction.sequence([move, faceMovement])
        } else {
            faceAction = move
        }
        player?.run(faceAction)
        
        shadow?.position = CGPoint(x: player!.position.x, y: player!.position.y - 47)
        
//        let parallax1 = SKAction.moveTo(x: (player?.position.x)!/(-10), duration: 0.0)
//        mountain1?.run(parallax1)
//
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    struct Collision {
        
        enum Masks: Int {
            case killing, player, reward, ground
            var bitmask: UInt32 { return 1 << self.rawValue }
        }
        
        let masks: (first: UInt32, second: UInt32)
        
        func matches (_ first: Masks, _ second: Masks) -> Bool {
            return (first.bitmask == masks.first && second.bitmask == masks.second) ||
            (first.bitmask == masks.second && second.bitmask == masks.first)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
                
        let collision = Collision(masks: (first: contact.bodyA.categoryBitMask, second: contact.bodyB.categoryBitMask))
        
        if collision.matches(.player, .killing) {
            print("Ih, morreu!")
            let die = SKAction.move(to: CGPoint(x: -800, y: -100), duration: 0.0)
            player?.run(die)
        }
        if collision.matches(.player, .ground){
            shadow?.alpha = 1
            playerStateMachine.enter(LandingState.self)
        }
        else{
            shadow?.alpha = 0
        }
        
    }
}
