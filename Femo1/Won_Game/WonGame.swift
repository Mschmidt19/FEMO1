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
    var newGameNode: SKSpriteNode!
    var starField: SKEmitterNode!
    let userDefaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        
        starField = (self.childNode(withName: "starField") as! SKEmitterNode)
        starField.advanceSimulationTime(14)
        
        newGameNode = self.childNode(withName: "New_game") as! SKSpriteNode

        celebration = SKEmitterNode(fileNamed: "celebration")
        celebration.position = CGPoint(x:160, y:320)
        self.addChild(celebration)
        celebration.zPosition = -1
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
            if node.first?.name == "New-game" || node.first?.name ==  "NewGameText" {
                userDefaults.set(false, forKey: "turnInProgress")
                let gameScene = GameScene(fileNamed: "GameScene")
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                self.view?.presentScene(gameScene!, transition: transition)
                gameScene!.resetGameState()
            }
            
        }
    }
    
}


