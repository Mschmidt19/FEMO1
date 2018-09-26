//
//  QuestionScene.swift
//  FEMO
//
//  Created by Marek Schmidt on 9/22/18.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import SpriteKit

class QuestionScene: SKScene {
  
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
    
//    func findSmallestFontSize(label1: SKLabelNode, label2: SKLabelNode, label3: SKLabelNode, label4: SKLabelNode, maxWidth: CGFloat) -> CGFloat {
//        var fontSize: CGFloat
//        let fontSizes = [label1.fitToWidth(maxWidth: maxWidth), label2.fitToWidth(maxWidth: maxWidth), label3.fitToWidth(maxWidth: maxWidth), label4.fitToWidth(maxWidth: maxWidth)]
//        print(fontSizes)
//        fontSize = fontSizes.min()!
//        print("smallest font size = \(fontSize)")
//        return fontSize
//    }
    
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

}
