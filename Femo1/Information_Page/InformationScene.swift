//
//  InformationScene.swift
//  FEMO
//
//  Created by Eunbit Evie Kim on 22/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import SpriteKit

class InformationScene: SKScene {
    
    var accessibleElements: [UIAccessibilityElement] = []
    
    var InformationNode: SKSpriteNode!
    var menu_buttonNode: SKSpriteNode!
    var play_buttonNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        menu_buttonNode = (self.childNode(withName: "Menu_button") as! SKSpriteNode)
        menu_buttonNode.texture = SKTexture(imageNamed: "menu_button")
        
        play_buttonNode = (self.childNode(withName: "Play_button") as! SKSpriteNode)
        play_buttonNode.texture = SKTexture(imageNamed: "playButton")
        
        menu_buttonNode.isAccessibilityElement = true
        play_buttonNode.isAccessibilityElement = true
      
    }
    
    override func willMove(from view: SKView) {
        accessibleElements.removeAll()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
          if node.first?.name == "Menu_button" {
                let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
                let menuPage = Main_page(fileNamed: "Main_page")
                self.view?.presentScene(menuPage!, transition: transition)
          } else if node.first?.name  == "Play_button" {
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                let gameScene = GameScene(fileNamed: "GameScene")
                self.view?.presentScene(gameScene!, transition: transition)
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
    
            let elementFormenu_buttonNode = UIAccessibilityElement(accessibilityContainer: self.view!)
            var frameFormenu_buttonNode = menu_buttonNode.frame
            frameFormenu_buttonNode.origin = (view?.convert(frameFormenu_buttonNode.origin, from: self))!
            frameFormenu_buttonNode.origin.y = frameFormenu_buttonNode.origin.y - frameFormenu_buttonNode.size.height
            elementFormenu_buttonNode.accessibilityIdentifier   = "Menu_button"
            elementFormenu_buttonNode.accessibilityFrame   = frameFormenu_buttonNode
            elementFormenu_buttonNode.accessibilityTraits  = UIAccessibilityTraitButton
            accessibleElements.append(elementFormenu_buttonNode)
            
            let elementForplay_buttonNode = UIAccessibilityElement(accessibilityContainer: self.view!)
            var frameForplay_buttonNode = play_buttonNode.frame
            frameForplay_buttonNode.origin = (view?.convert(frameForplay_buttonNode.origin, from: self))!
            frameForplay_buttonNode.origin.y = frameForplay_buttonNode.origin.y - frameForplay_buttonNode.size.height
            elementForplay_buttonNode.accessibilityIdentifier   = "Play_button"
            elementForplay_buttonNode.accessibilityFrame   = frameForplay_buttonNode
            elementForplay_buttonNode.accessibilityTraits  = UIAccessibilityTraitButton
            accessibleElements.append(elementForplay_buttonNode)
        }
    }
}
