//
//  GameScene.swift
//  Indiana Codes
//
//  Created by Marek Schmidt on 9/19/18.
//  Copyright © 2018 Marek Schmidt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    let userDefaults = UserDefaults.standard

    var viewController: GameViewController!

    var tilesArray:[SKSpriteNode]? = [SKSpriteNode]()
    var player1:SKSpriteNode?
    var computer:SKSpriteNode?

    var blackhole1:SKSpriteNode?
    var blackhole2:SKSpriteNode?
    var blackholeLocations = [Int]()

    var currentTile = 0
    var currentTileComputer = 0

    var movingToTile = false
    var computerMovingToTile = false

    var moveDuration = 0.4
    var indexOfLastTile = 0
    var arrsize: Int{
        get {
            return tilesArray!.count
        }
    }

    var dieRoll = 0

    let tilePenalty = 3

    let textDisappearTimer = 4.0

    var questionInProgress = false

    var starField: SKEmitterNode!
    var lastAnswerLabel: SKLabelNode!
    var dieRollLabel: SKLabelNode!
    var menu_buttonNode:SKSpriteNode!
    var InformationNode:SKSpriteNode!

    let moveSound = SKAction.playSoundFileNamed("tap.wav", waitForCompletion: false)

    func setupTiles() {
        for i in 1...100 {
            if let tile = self.childNode(withName: "tile\(i)") as? SKSpriteNode {
                tilesArray?.append(tile)
            }
        }
    }

    func setupBlackholes() {
        blackhole1 = SKSpriteNode(imageNamed: "blackhole")
        blackhole1?.size.height = 25.0
        blackhole1?.size.width = 25.0
        blackhole2 = SKSpriteNode(imageNamed: "blackhole")
        blackhole2?.size.height = 25.0
        blackhole2?.size.width = 25.0

        var location1: Int
        var location2: Int
        if isKeyPresentInUserDefaults(key: "blackholeLocations") {
            blackholeLocations = (userDefaults.array(forKey: "blackholeLocations") as! [Int])
            location1 = blackholeLocations[0]
            location2 = blackholeLocations[1]


        } else {
            location1 = (Int(arc4random_uniform(UInt32(tilesArray!.count - tilePenalty - 2))) + tilePenalty)
            location2 = location1
            while location2 == location1 {
                location2 = (Int(arc4random_uniform(UInt32(tilesArray!.count - tilePenalty - 2))) + tilePenalty)
            }
            blackholeLocations.append(location1)
            blackholeLocations.append(location2)
        }

        guard let blackhole1PositionX = tilesArray?[location1].position.x else {return}
        guard let blackhole1PositionY = tilesArray?[location1].position.y else {return}
        guard let blackhole2PositionX = tilesArray?[location2].position.x else {return}
        guard let blackhole2PositionY = tilesArray?[location2].position.y else {return}

        blackhole1?.position = CGPoint(x: blackhole1PositionX, y: blackhole1PositionY)
        blackhole2?.position = CGPoint(x: blackhole2PositionX, y: blackhole2PositionY)

        self.addChild(blackhole1!)
        self.addChild(blackhole2!)
    }

    func createPlayer1() {
        player1 = SKSpriteNode(imageNamed: "character")

        if isKeyPresentInUserDefaults(key: "currentTile") {
            currentTile = userDefaults.integer(forKey: "currentTile")
        } else {
            currentTile = 0
        }

        guard let player1PositionX = tilesArray?[currentTile].position.x else {return}
        guard let player1PositionY = tilesArray?[currentTile].position.y else {return}
        player1?.position = CGPoint(x: player1PositionX, y: player1PositionY + 15)

        if isKeyPresentInUserDefaults(key: "playerXScale") {
            player1?.xScale = CGFloat(userDefaults.integer(forKey: "playerXScale"))
        } else {
            player1?.xScale = 1.0
        }

        player1?.zPosition = 5

        self.addChild(player1!)
    }

    func createComputer() {
        computer = SKSpriteNode(imageNamed: "robot1")

        if isKeyPresentInUserDefaults(key: "currentTileComputer") {
            currentTileComputer = userDefaults.integer(forKey: "currentTileComputer")
        } else {
            currentTileComputer = 0
        }

        guard let computerPositionX = tilesArray?[currentTileComputer].position.x else {return}
        guard let computerPositionY = tilesArray?[currentTileComputer].position.y else {return}
        computer?.position = CGPoint(x: computerPositionX, y: computerPositionY + 15)

        if isKeyPresentInUserDefaults(key: "computerXScale") {
            computer?.xScale = CGFloat(userDefaults.integer(forKey: "computerXScale"))
        } else {
            computer?.xScale = 1.0
        }

        computer?.zPosition = 4

        self.addChild(computer!)
    }

    override func didMove(to view: SKView) {
        setupTiles()
        setupBlackholes()

        createPlayer1()
        createComputer()

        starField = (self.childNode(withName: "starField") as! SKEmitterNode)
        starField.advanceSimulationTime(14)
        menu_buttonNode = (self.childNode(withName: "Menu_button") as! SKSpriteNode)
        menu_buttonNode.texture = SKTexture(imageNamed: "menu_button")
        InformationNode = (self.childNode(withName: "Information_button") as! SKSpriteNode)
        InformationNode.texture = SKTexture(imageNamed: "information_button")

        indexOfLastTile = (tilesArray?.index{$0 === tilesArray?.last})!

        dieRollLabel = (self.childNode(withName: "dieRollLabel") as! SKLabelNode)

        lastAnswerLabel = (self.childNode(withName: "popupAnswerLabel") as! SKLabelNode)

        displayCorrectOrIncorrectWithTimer()

        if canPlayTurn() {
            playTurn()
        } else if userDefaults.bool(forKey: "turnInProgress"){
            playComputerTurn()
        }

    }

    func moveToNextTile() {
        player1?.removeAllActions()
        movingToTile = true

        guard let nextTile = tilesArray?[currentTile + 1] else {return}


        if nextTile == self.childNode(withName: "tile7") {
            player1?.xScale = -1.0
        } else if nextTile == self.childNode(withName: "tile16") {
            player1?.xScale = 1.0
        } else if nextTile == self.childNode(withName: "tile30") {
            wonGame()
        }

        if let player1 = self.player1 {
            currentTile += 1

            let moveAction = SKAction.move(to: CGPoint(x: nextTile.position.x, y: nextTile.position.y + 15), duration: moveDuration)
            player1.run(moveAction, completion: {
                self.movingToTile = false
            })

            self.run(moveSound)
        }
    }

    func moveToPreviousTile() {
        player1?.removeAllActions()
        movingToTile = true

        guard let previousTile = tilesArray?[currentTile - 1] else {return}


        if previousTile == self.childNode(withName: "tile7") {
            player1?.xScale = 1.0
        } else if previousTile == self.childNode(withName: "tile16") {
            player1?.xScale = -1.0
        }

        if let player1 = self.player1 {
            currentTile -= 1

            let moveAction = SKAction.move(to: CGPoint(x: previousTile.position.x, y: previousTile.position.y + 15), duration: moveDuration)
            player1.run(moveAction, completion: {
                self.movingToTile = false
            })

            self.run(moveSound)
        }
    }

    func moveComputerToNextTile() {
        computer?.removeAllActions()
        computerMovingToTile = true

        guard let nextTileComputer = tilesArray?[currentTileComputer + 1] else {return}


        if nextTileComputer == self.childNode(withName: "tile7") {
            computer?.xScale = -1.0
        } else if nextTileComputer == self.childNode(withName: "tile16") {
            computer?.xScale = 1.0
        } else if nextTileComputer == self.childNode(withName: "tile30") {
            lostGame()
        }

        if let computer = self.computer {
            currentTileComputer += 1

            let moveAction = SKAction.move(to: CGPoint(x: nextTileComputer.position.x, y: nextTileComputer.position.y + 15), duration: moveDuration)
            computer.run(moveAction, completion: {
                self.computerMovingToTile = false
            })

            self.run(moveSound)
        }
    }

    func moveComputerToPreviousTile() {
        computer?.removeAllActions()
        computerMovingToTile = true

        guard let previousTile = tilesArray?[currentTileComputer - 1] else {return}


        if previousTile == self.childNode(withName: "tile7") {
            computer?.xScale = 1.0
        } else if previousTile == self.childNode(withName: "tile16") {
            computer?.xScale = -1.0
        }

        if let computer = self.computer {
            currentTileComputer -= 1

            let moveAction = SKAction.move(to: CGPoint(x: previousTile.position.x, y: previousTile.position.y + 15), duration: moveDuration)
            computer.run(moveAction, completion: {
                self.movingToTile = false
            })

            self.run(moveSound)
        }
    }

    func rollDie(name: String) {
        let roll = arc4random_uniform(_:6) + 1
        if name == "You" {
            if indexOfLastTile - currentTile < roll {
                dieRoll = Int(indexOfLastTile - currentTile)
            } else {
            dieRoll = Int(roll)
            }
        } else {
            if indexOfLastTile - currentTileComputer < roll {
                dieRoll = Int(indexOfLastTile - currentTileComputer)
            } else {
                dieRoll = Int(roll)
            }
        }
    }

    func displayDieRollWithTimer(name: String) {
        dieRollLabel.fontSize = 28.0
        dieRollLabel.text = "\(name) rolled a \(dieRoll)"
        DispatchQueue.main.asyncAfter(deadline: .now() + textDisappearTimer) {
            self.dieRollLabel.text = ""
        }
    }

    func displayBlackholePenaltyWithTimer(name: String) {
        dieRollLabel.fontSize = 20.0
        dieRollLabel.text = "\(name) landed on a black hole!"
        DispatchQueue.main.asyncAfter(deadline: .now() + textDisappearTimer) {
            self.dieRollLabel.text = ""
        }
    }

    func displayCorrectOrIncorrectWithTimer() {
        if userDefaults.bool(forKey: "turnInProgress") {
            if isKeyPresentInUserDefaults(key: "lastAnswerCorrect") {
                if userDefaults.bool(forKey: "lastAnswerCorrect") == true {
                    lastAnswerLabel.fontColor = SKColor.green
                    lastAnswerLabel.text = "Correct"
                } else {
                    lastAnswerLabel.fontColor = SKColor.red
                    lastAnswerLabel.text = "Incorrect"
                }
            } else {
                lastAnswerLabel.text = ""
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + textDisappearTimer) {
                self.lastAnswerLabel.text = ""
            }
        }
    }

    func playTurn() {
        rollDie(name: "You")
        displayDieRollWithTimer(name: "You")
        var delayAdder = moveDuration
        if dieRoll > 0 {
            for _ in 1 ... dieRoll {
                DispatchQueue.main.asyncAfter(deadline: .now() + delayAdder) {
                    self.moveToNextTile()
                }
                delayAdder += moveDuration
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + delayAdder + 1.0) {
                if self.blackholeLocations.contains(self.currentTile) {
                    self.displayBlackholePenaltyWithTimer(name: "You")
                    self.goBackXTiles(number: self.tilePenalty, character: self.player1!)
                    delayAdder += (Double(self.tilePenalty) * self.moveDuration)

                    DispatchQueue.main.asyncAfter(deadline: .now() + delayAdder - 2.0) {
                        self.playComputerTurn()
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + delayAdder - 2.0) {
                        self.playComputerTurn()
                    }
                }
            }
        }
    }

    func playComputerTurn() {
        rollDie(name: "Computer")
        displayDieRollWithTimer(name: "Computer")
        var delayAdder = moveDuration
        if dieRoll > 0 {
            for _ in 1 ... dieRoll {
                DispatchQueue.main.asyncAfter(deadline: .now() + delayAdder) {
                    self.moveComputerToNextTile()
                }
                delayAdder += moveDuration
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + delayAdder + 1.0) {
                if self.blackholeLocations.contains(self.currentTileComputer) {
                    self.displayBlackholePenaltyWithTimer(name: "Computer")
                    self.goBackXTiles(number: self.tilePenalty, character: self.computer!)
                    delayAdder += (Double(self.tilePenalty) * self.moveDuration)

                    DispatchQueue.main.asyncAfter(deadline: .now() + delayAdder - 2.0) {
                        self.userDefaults.set(false, forKey: "turnInProgress")
                    }
                }else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + delayAdder - 2.0) {
                        self.userDefaults.set(false, forKey: "turnInProgress")
                    }
                }
            }
        }

    }

    func goBackXTiles(number: Int, character: SKSpriteNode) {
        var delayAdder = moveDuration
        if character == player1 {
            for _ in 1 ... number {
                DispatchQueue.main.asyncAfter(deadline: .now() + delayAdder) {
                    self.moveToPreviousTile()
                }
                delayAdder += moveDuration
            }
        } else if character == computer {
            for _ in 1 ... number {
                DispatchQueue.main.asyncAfter(deadline: .now() + delayAdder) {
                    self.moveComputerToPreviousTile()
                }
                delayAdder += moveDuration
            }
        }

    }

    func askQuestion() {
        userDefaults.set(true, forKey: "turnInProgress")
        saveGameState()
        let transition = SKTransition.reveal(with: .up, duration: 0.5)
        let questionScene = GameScene(fileNamed: "QuestionScene")
        self.view?.presentScene(questionScene!, transition: transition)
    }

    func goToInfoScene() {
        saveGameState()
        let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
        let information = InformationScene(fileNamed: "Information")
        self.view?.presentScene(information!, transition: transition)
    }

    func goToHomeScene() {
        saveGameState()
        let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
        let menuPage = Main_page(fileNamed: "Main_page")
        self.view?.presentScene(menuPage!, transition: transition)
    }

    func canPlayTurn() -> Bool {
        if (userDefaults.bool(forKey: "lastAnswerCorrect") && userDefaults.bool(forKey: "turnInProgress")) {
            return true
        } else {
            return false
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first

            if node?.name == "nextTileButton" || node?.name == "NextMoveTextLabel"{
                if userDefaults.bool(forKey: "turnInProgress") == false {
                   askQuestion()
                }
            } else if node?.name == "Menu_button" || node?.name == "Menu"{
                goToHomeScene()
            } else if node?.name == "Information_button" || node?.name == "InformationTextLabel"{
                goToInfoScene()
            }
        }
    }

    func wonGame() {
        let transition = SKTransition.flipVertical(withDuration: 0.5)
        let wongame = WonGame(fileNamed: "WonGame")
        self.view?.presentScene(wongame!, transition: transition)
    }

    func lostGame() {
        let transition = SKTransition.flipVertical(withDuration: 0.5)
        let lostgame = LostGame(fileNamed: "LostGame")
        self.view?.presentScene(lostgame!, transition: transition)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !movingToTile {
            player1?.removeAllActions()
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !movingToTile {
            player1?.removeAllActions()
        }
    }


    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

    func resetGameState() {
        print("resetting game state")
        let bundleIdentifier = Bundle.main.bundleIdentifier!
        userDefaults.removePersistentDomain(forName: bundleIdentifier)

        currentTile = 0
        player1?.position = CGPoint(x: tilesArray!.first!.position.x, y: tilesArray!.first!.position.y + 15)
        player1?.xScale = 1
        currentTileComputer = 0
        computer?.position = CGPoint(x: tilesArray!.first!.position.x, y: tilesArray!.first!.position.y + 15)
        computer?.xScale = 1


        var location1: Int
        var location2: Int
        location1 = (Int(arc4random_uniform(UInt32(tilesArray!.count - tilePenalty))) + tilePenalty)
        location2 = location1
        while location2 == location1 {
            location2 = (Int(arc4random_uniform(UInt32(tilesArray!.count - tilePenalty - 1))) + tilePenalty)
        }

        guard let blackhole1PositionX = tilesArray?[location1].position.x else {return}
        guard let blackhole1PositionY = tilesArray?[location1].position.y else {return}
        guard let blackhole2PositionX = tilesArray?[location2].position.x else {return}
        guard let blackhole2PositionY = tilesArray?[location2].position.y else {return}

        blackhole1?.position = CGPoint(x: blackhole1PositionX, y: blackhole1PositionY)
        blackhole2?.position = CGPoint(x: blackhole2PositionX, y: blackhole2PositionY)

        blackholeLocations = [Int]()
        blackholeLocations.append(location1)
        blackholeLocations.append(location2)
    }

    func saveGameState() {
        userDefaults.set(currentTile, forKey: "currentTile")
        userDefaults.set(currentTileComputer, forKey:"currentTileComputer")
        userDefaults.set(player1?.xScale, forKey: "playerXScale")
        userDefaults.set(computer?.xScale, forKey: "computerXScale")
        userDefaults.set(blackholeLocations, forKey: "blackholeLocations")
    }

    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return userDefaults.object(forKey: key) != nil
    }
}
