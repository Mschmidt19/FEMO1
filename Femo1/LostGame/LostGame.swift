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
    
    override func didMove(to view: SKView) {
        _ = self.childNode(withName: "NewGame") as! SKSpriteNode
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
        
        if node.first?.name == "NewGame" {
            let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
            let menuPage = Main_page(fileNamed: "Main_page")
            self.view?.presentScene(menuPage!, transition: transition)
            }
        }
    }
}
