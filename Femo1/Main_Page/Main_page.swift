//
//  Main_page.swift
//  FEMO
//
//  Created by Eunbit Evie Kim on 22/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import SpriteKit

class Main_page: SKScene {

    let userDefaults = UserDefaults.standard
    var ResumeGameNode: SKSpriteNode!
    var New_GameNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        ResumeGameNode = (self.childNode(withName: "ResumeGame") as! SKSpriteNode)
        New_GameNode = (self.childNode(withName: "New_game") as! SKSpriteNode)
        
        ResumeGameNode.texture = SKTexture(imageNamed: "new_button")
        New_GameNode.texture = SKTexture(imageNamed: "new_button")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
           let node = self.nodes(at: location).first
            if node?.name  == "ResumeGame" || node?.name == "ResumeGameText" {
                userDefaults.set(false, forKey: "turnInProgress")
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                let gameScene = GameScene(fileNamed: "GameScene")
                self.view?.presentScene(gameScene!, transition: transition)
            }
            
            if node?.name  == "New_game" || node?.name == "NewGameText" {
                let gameScene = GameScene(fileNamed: "GameScene")
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                self.view?.presentScene(gameScene!, transition: transition)
                gameScene!.resetGameState()
            }
        }
    }
    
}
