//
//  LostGame.swift
//  Femo1
//
//  Created by Farah Jabri on 25/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import SpriteKit
import GameplayKit

class LostGame: SKScene {
    var newGameNode: SKSpriteNode!
    var starField: SKEmitterNode!
    let userDefaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        starField = (self.childNode(withName: "starField") as! SKEmitterNode)
        starField.advanceSimulationTime(14)
        
        newGameNode = self.childNode(withName: "NewGame") as! SKSpriteNode
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
        
        if node.first?.name == "NewGame" || node.first?.name == "tryAgain"{
            userDefaults.set(false, forKey: "turnInProgress")
            let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
            let gameScene = GameScene(fileNamed: "GameScene")
            self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }
}
