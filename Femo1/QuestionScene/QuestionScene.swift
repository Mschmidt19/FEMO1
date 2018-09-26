//
//  QuestionScene.swift
//  FEMO
//
//  Created by Marek Schmidt on 9/22/18.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import SpriteKit

class QuestionScene: SKScene {
    
    var accessibleElements: [UIAccessibilityElement] = []
    
    let userDefaults = UserDefaults.standard
    
    var questionList = [Question]()
    var questionOrderArray = [Int]()
    var currentQuestion = 0
    
    var starField: SKEmitterNode!
    
    var questionText: SKLabelNode!
    var button1Text: SKLabelNode!
    var button2Text: SKLabelNode!
    var button3Text: SKLabelNode!
    var button4Text: SKLabelNode!
    var button1Background: SKSpriteNode!
    var button2Background: SKSpriteNode!
    var button3Background: SKSpriteNode!
    var button4Background: SKSpriteNode!
    
    let buttonNames = ["button1Text", "button1Background", "button2Text", "button2Background", "button3Text", "button3Background", "button4Text", "button4Background"]
    
    override func didMove(to view: SKView) {
        isAccessibilityElement = false
        
        starField = (self.childNode(withName: "starField") as! SKEmitterNode)
        starField.advanceSimulationTime(14)

        questionText = (self.childNode(withName: "questionText") as! SKLabelNode)
        button1Text = (self.childNode(withName: "button1Text") as! SKLabelNode)
        button2Text = (self.childNode(withName: "button2Text") as! SKLabelNode)
        button3Text = (self.childNode(withName: "button3Text") as! SKLabelNode)
        button4Text = (self.childNode(withName: "button4Text") as! SKLabelNode)
        button1Background = (self.childNode(withName: "button1Background") as! SKSpriteNode)
        button2Background = (self.childNode(withName: "button2Background") as! SKSpriteNode)
        button3Background = (self.childNode(withName: "button3Background") as! SKSpriteNode)
        button4Background = (self.childNode(withName: "button4Background") as! SKSpriteNode)
        
        button1Text.isAccessibilityElement = true
        button1Background.isAccessibilityElement = true
        button2Text.isAccessibilityElement = true
        button2Background.isAccessibilityElement = true
        button3Text.isAccessibilityElement = true
        button3Background.isAccessibilityElement = true
        button4Text.isAccessibilityElement = true
        button4Background.isAccessibilityElement = true
        
        let questionClass = QuestionList()
        let questionListFromClass = questionClass.list
        let questionListFromDefaults = userDefaults.array(forKey: "questionList")
        if isKeyPresentInUserDefaults(key: "questionList") {
            questionList = questionListFromDefaults as! [Question]
        } else {
            questionList = questionListFromClass
        }
        
        if isKeyPresentInUserDefaults(key: "questionOrderArray") {
            questionOrderArray = userDefaults.array(forKey: "questionOrderArray") as! [Int]
        } else {
            createQuestionOrderArray()
        }
        
        if isKeyPresentInUserDefaults(key: "currentQuestion") {
            currentQuestion = userDefaults.integer(forKey: "currentQuestion")
        } else {
            currentQuestion = 0
        }
        
        let questionCount = questionList.count
        
        let maxQuestionWidth = 300 as CGFloat
        let maxAnswerWidth = 280 as CGFloat
        
        questionText.text = (questionList[questionOrderArray[currentQuestion % questionCount]].question)
        questionText.lineBreakMode = NSLineBreakMode.byWordWrapping
        questionText.preferredMaxLayoutWidth = maxQuestionWidth
        questionText.numberOfLines = 0
        
        button1Text.text = (questionList[questionOrderArray[currentQuestion % questionCount]].optionA)
        button1Text.fitToWidth(maxWidth: maxAnswerWidth)
        button2Text.text = (questionList[questionOrderArray[currentQuestion % questionCount]].optionB)
        button2Text.fitToWidth(maxWidth: maxAnswerWidth)
        button3Text.text = (questionList[questionOrderArray[currentQuestion % questionCount]].optionC)
        button3Text.fitToWidth(maxWidth: maxAnswerWidth)
        button4Text.text = (questionList[questionOrderArray[currentQuestion % questionCount]].optionD)
        button4Text.fitToWidth(maxWidth: maxAnswerWidth)

        let fontSizes = [button1Text.fontSize, button2Text.fontSize, button3Text.fontSize, button4Text.fontSize]
        let smallestFontSize = fontSizes.min()
        button1Text.fontSize = smallestFontSize!
        button2Text.fontSize = smallestFontSize!
        button3Text.fontSize = smallestFontSize!
        button4Text.fontSize = smallestFontSize!
    }
    
    override func willMove(from view: SKView) {
        accessibleElements.removeAll()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            if let node = self.nodes(at: location).first {
                if buttonNames.contains(node.name!) {
                    answerButtonPressed(node: node)
                }
            }
        }
        
    }
    
    func createQuestionOrderArray() {
        var tempArray = [Int]()
        for i in 0...questionList.count-1 {
            tempArray.append(i)
        }
        questionOrderArray = shuffleArray(array: tempArray)
    }
    
    func shuffleArray(array: [Int]) -> [Int] {
        var items = array
        var shuffled = [Int]();
        
        for _ in 0..<items.count {
            let rand = Int(arc4random_uniform(UInt32(items.count)))
            
            shuffled.append(items[rand])
            
            items.remove(at: rand)
        }
        
        return shuffled
    }
    
    func presentSpaceBoard() {
        let transition = SKTransition.reveal(with: .up, duration: 0.5)
        
        let spaceGameScene = GameScene(fileNamed: "GameScene")
        self.view?.presentScene(spaceGameScene!, transition: transition)
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return userDefaults.object(forKey: key) != nil
    }
    
    func saveGameState() {
        userDefaults.set(currentQuestion, forKey: "currentQuestion")
        userDefaults.set(questionOrderArray, forKey: "questionOrderArray")
    }
    
    func answerButtonPressed(node: SKNode) {
        let questionCount = questionList.count
        let tag = ((node.userData!.object(forKey: "tag")!) as! Int)
        if tag == (questionList[questionOrderArray[currentQuestion % questionCount]].correctAnswer) {
            userDefaults.set(true, forKey: "lastAnswerCorrect")
        } else {
            userDefaults.set(false, forKey: "lastAnswerCorrect")
        }
        currentQuestion += 1
        saveGameState()
        presentSpaceBoard()
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
            
            // 1.
            let elementForButton1Text = UIAccessibilityElement(accessibilityContainer: self.view!)
            let elementForButton1Background = UIAccessibilityElement(accessibilityContainer: self.view!)
            let elementForButton2Text = UIAccessibilityElement(accessibilityContainer: self.view!)
            let elementForButton2Background = UIAccessibilityElement(accessibilityContainer: self.view!)
            let elementForButton3Text = UIAccessibilityElement(accessibilityContainer: self.view!)
            let elementForButton3Background = UIAccessibilityElement(accessibilityContainer: self.view!)
            let elementForButton4Text = UIAccessibilityElement(accessibilityContainer: self.view!)
            let elementForButton4Background = UIAccessibilityElement(accessibilityContainer: self.view!)
            
            // 2.
            var frameForButton1Text = button1Text.frame
            var frameForButton1Background = button1Background.frame
            var frameForButton2Text = button1Text.frame
            var frameForButton2Background = button1Background.frame
            var frameForButton3Text = button1Text.frame
            var frameForButton3Background = button1Background.frame
            var frameForButton4Text = button1Text.frame
            var frameForButton4Background = button1Background.frame
            
            // From Scene to View
            frameForButton1Text.origin = (view?.convert(frameForButton1Text.origin, from: self))!
            frameForButton1Background.origin = (view?.convert(frameForButton1Background.origin, from: self))!
            frameForButton2Text.origin = (view?.convert(frameForButton1Text.origin, from: self))!
            frameForButton2Background.origin = (view?.convert(frameForButton1Background.origin, from: self))!
            frameForButton3Text.origin = (view?.convert(frameForButton1Text.origin, from: self))!
            frameForButton3Background.origin = (view?.convert(frameForButton1Background.origin, from: self))!
            frameForButton4Text.origin = (view?.convert(frameForButton1Text.origin, from: self))!
            frameForButton4Background.origin = (view?.convert(frameForButton1Background.origin, from: self))!
            
            // Don't forget origins are different for SpriteKit and UIKit:
            // - SpriteKit is bottom/left
            // - UIKit is top/left
            //              y
            //  ┌────┐       ▲
            //  │    │       │   x
            //  ◉────┘       └──▶
            //
            //                   x
            //  ◉────┐       ┌──▶
            //  │    │       │
            //  └────┘     y ▼
            //
            // Thus before the following conversion, origin value indicate the bottom/left edge of the frame.
            // We then need to move it to top/left by retrieving the height of the frame.
            //
            
            frameForButton1Text.origin.y = frameForButton1Text.origin.y - frameForButton1Text.size.height
            frameForButton1Background.origin.y = frameForButton1Background.origin.y - frameForButton1Background.size.height
            frameForButton2Text.origin.y = frameForButton2Text.origin.y - frameForButton2Text.size.height
            frameForButton2Background.origin.y = frameForButton2Background.origin.y - frameForButton2Background.size.height
            frameForButton3Text.origin.y = frameForButton3Text.origin.y - frameForButton3Text.size.height
            frameForButton3Background.origin.y = frameForButton3Background.origin.y - frameForButton3Background.size.height
            frameForButton4Text.origin.y = frameForButton4Text.origin.y - frameForButton4Text.size.height
            frameForButton4Background.origin.y = frameForButton4Background.origin.y - frameForButton4Background.size.height
            
            
            // 3.
            elementForButton1Text.accessibilityLabel   = "button1Text"
            elementForButton1Text.accessibilityFrame   = frameForButton1Text
            elementForButton1Text.accessibilityTraits  = UIAccessibilityTraitButton
            elementForButton1Background.accessibilityLabel   = "button1Background"
            elementForButton1Background.accessibilityFrame   = frameForButton1Background
            elementForButton1Background.accessibilityTraits  = UIAccessibilityTraitButton
            elementForButton2Text.accessibilityLabel   = "button2Text"
            elementForButton2Text.accessibilityFrame   = frameForButton2Text
            elementForButton2Text.accessibilityTraits  = UIAccessibilityTraitButton
            elementForButton2Background.accessibilityLabel   = "button2Background"
            elementForButton2Background.accessibilityFrame   = frameForButton2Background
            elementForButton2Background.accessibilityTraits  = UIAccessibilityTraitButton
            elementForButton3Text.accessibilityLabel   = "button3Text"
            elementForButton3Text.accessibilityFrame   = frameForButton3Text
            elementForButton3Text.accessibilityTraits  = UIAccessibilityTraitButton
            elementForButton3Background.accessibilityLabel   = "button3Background"
            elementForButton3Background.accessibilityFrame   = frameForButton3Background
            elementForButton3Background.accessibilityTraits  = UIAccessibilityTraitButton
            elementForButton4Text.accessibilityLabel   = "button4Text"
            elementForButton4Text.accessibilityFrame   = frameForButton4Text
            elementForButton4Text.accessibilityTraits  = UIAccessibilityTraitButton
            elementForButton4Background.accessibilityLabel   = "button4Background"
            elementForButton4Background.accessibilityFrame   = frameForButton4Background
            elementForButton4Background.accessibilityTraits  = UIAccessibilityTraitButton
            
            // 4.
            accessibleElements.append(elementForButton1Text)
            accessibleElements.append(elementForButton1Background)
            accessibleElements.append(elementForButton2Text)
            accessibleElements.append(elementForButton2Background)
            accessibleElements.append(elementForButton3Text)
            accessibleElements.append(elementForButton3Background)
            accessibleElements.append(elementForButton4Text)
            accessibleElements.append(elementForButton4Background)
            
        }
    }

}
