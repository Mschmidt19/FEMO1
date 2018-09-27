//
//  Main_page.swift
//  FEMO
//
//  Created by Eunbit Evie Kim on 22/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import SpriteKit

class Main_page: SKScene {
    
    var accessibleElements: [UIAccessibilityElement] = []

    let userDefaults = UserDefaults.standard
    var ResumeGameNode: SKSpriteNode!
    var New_GameNode: SKSpriteNode!
    var ResumeGameText: SKLabelNode!
    var NewGameText: SKLabelNode!
    
    override func didMove(to view: SKView) {
        ResumeGameNode = (self.childNode(withName: "ResumeGame") as! SKSpriteNode)
        New_GameNode = (self.childNode(withName: "NewGame") as! SKSpriteNode)
        
        ResumeGameNode.texture = SKTexture(imageNamed: "new_button")
        ResumeGameText = (self.childNode(withName: "ResumeGameText") as! SKLabelNode)
        
        New_GameNode.texture = SKTexture(imageNamed: "new_button")
        NewGameText = (self.childNode(withName: "NewGameText") as! SKLabelNode)
        
        ResumeGameNode.isAccessibilityElement = true
        ResumeGameText.isAccessibilityElement = true
        
        New_GameNode.isAccessibilityElement = true
        NewGameText.isAccessibilityElement = true
    }
    
    override func willMove(from view: SKView) {
        accessibleElements.removeAll()
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
            
            if node?.name  == "NewGame" || node?.name == "NewGameText" {
                userDefaults.set(false, forKey: "turnInProgress")
                let gameScene = GameScene(fileNamed: "GameScene")
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                self.view?.presentScene(gameScene!, transition: transition)
                gameScene!.resetGameState()
            }
        }
    }
    
    override func accessibilityElementCount() -> Int {
        initAccessibility()
        return accessibleElements.count
    }
    
    override func accessibilityElement(at index: Int) -> Any? {
        
        initAccessibility()
        if (index < accessibleElements.count) {
            return accessibleElements[index]
        } else {
            return nil
        }
    }
    
    override func index(ofAccessibilityElement element: Any) -> Int {
        initAccessibility()
        return accessibleElements.index(of: element as! UIAccessibilityElement)!
    }
    
    func initAccessibility() {
        
        if accessibleElements.count == 0 {
            
            let elementForResumeGameNode = UIAccessibilityElement(accessibilityContainer: self.view!)
            var frameForResumeGameNode = ResumeGameNode.frame
            frameForResumeGameNode.origin = (view?.convert(frameForResumeGameNode.origin, from: self))!
            frameForResumeGameNode.origin.y = frameForResumeGameNode.origin.y - frameForResumeGameNode.size.height
            elementForResumeGameNode.accessibilityIdentifier   = "ResumeGame"
            elementForResumeGameNode.accessibilityFrame   = frameForResumeGameNode
            elementForResumeGameNode.accessibilityTraits  = UIAccessibilityTraitButton
            accessibleElements.append(elementForResumeGameNode)
            
            
            let elementForNew_GameNode = UIAccessibilityElement(accessibilityContainer: self.view!)
            var frameForNew_GameNode = New_GameNode.frame
            frameForNew_GameNode.origin = (view?.convert(frameForNew_GameNode.origin, from: self))!
            frameForNew_GameNode.origin.y = frameForNew_GameNode.origin.y - frameForNew_GameNode.size.height
            elementForNew_GameNode.accessibilityIdentifier   = "NewGame"
            elementForNew_GameNode.accessibilityFrame   = frameForNew_GameNode
            elementForNew_GameNode.accessibilityTraits  = UIAccessibilityTraitButton
            accessibleElements.append(elementForNew_GameNode)
            
            let elementForResumeGameText = UIAccessibilityElement(accessibilityContainer: self.view!)
            var frameForResumeGameText = ResumeGameText.frame
            frameForResumeGameText.origin = (view?.convert(frameForResumeGameText.origin, from: self))!
            frameForResumeGameText.origin.y = frameForResumeGameText.origin.y - frameForResumeGameText.size.height
            elementForResumeGameText.accessibilityLabel   = "ResumeGameText"
            elementForResumeGameText.accessibilityFrame   = frameForResumeGameText
            elementForResumeGameText.accessibilityTraits  = UIAccessibilityTraitButton
            accessibleElements.append(elementForResumeGameText)
            
            let elementForNewGameText = UIAccessibilityElement(accessibilityContainer: self.view!)
            var frameForNewGameText = NewGameText.frame
            frameForNewGameText.origin = (view?.convert(frameForNewGameText.origin, from: self))!
            frameForNewGameText.origin.y = frameForNewGameText.origin.y - frameForNewGameText.size.height
            elementForNewGameText.accessibilityLabel   = "NewGameText"
            elementForNewGameText.accessibilityFrame   = frameForResumeGameText
            elementForNewGameText.accessibilityTraits  = UIAccessibilityTraitButton
            accessibleElements.append(elementForNewGameText)
        }
    }
    
}
