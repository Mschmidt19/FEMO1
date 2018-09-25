//
//  WonGame.swift
//  Femo1
//
//  Created by Farah Jabri on 25/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import SpriteKit
import GameplayKit

class WonGame: SKScene {
    var celebration:SKEmitterNode!
    
    override func didMove(to view: SKView) {
        celebration = SKEmitterNode(fileNamed: "celebration")
        celebration.position = CGPoint(x:160, y:320)
        self.addChild(celebration)
        celebration.zPosition = -1
    }
    
    
}
