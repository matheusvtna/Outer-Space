//
//  Message.swift
//  Outer Space
//
//  Created by Samuel Brasileiro on 30/06/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//

import Foundation
import GameplayKit

class Message{
    var text: String
    var condition: () -> Bool
    var duration: Double?
    var completion: Bool
    var position: CGPoint
    var label: SKLabelNode
    
    init(text: String, position: CGPoint, condition: @escaping () -> Bool){
        self.completion = false
        self.position = position
        self.text = text
        self.condition = condition
        
        label = SKLabelNode(fontNamed: "Nexa Light")
        label.horizontalAlignmentMode = .center
        
        label.numberOfLines = 3
        label.preferredMaxLayoutWidth = 200
        label.fontSize = 18
        label.fontColor = SKColor(red: 0x23/0xff, green: 0x23/0xff, blue: 0x23/0xff, alpha: 1)
        
    }
}
