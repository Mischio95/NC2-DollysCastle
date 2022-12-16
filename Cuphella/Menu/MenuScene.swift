//
//  MenuScene.swift
//  Cuphella
//
//  Created by Michele Trombone  on 10/12/22.
//

import SpriteKit
import SceneKit



class MenuScene: SKScene
{
    var newGameButtonNode:SKSpriteNode!
    var allScoreButtonNode:SKSpriteNode!
    var dollyHistoryNode:SKSpriteNode!
    var inputButton:SKSpriteNode!
    
    var vibrationNode:SKSpriteNode!
    var textLabel :SKLabelNode!
    var backgroundGif: SKSpriteNode!
    var animation: SKAction!
    var touchButton = false
    var countTouch = 1
    
    override func didMove(to view: SKView)
    {
        newGameButtonNode = self.childNode(withName: "newGameButton") as? SKSpriteNode
        allScoreButtonNode = self.childNode(withName: "allScoreButton") as? SKSpriteNode
        dollyHistoryNode = self.childNode(withName: "historyDollyButton") as? SKSpriteNode
        //        vibrationNode = self.childNode(withName: "vibrationButton") as? SKSpriteNode
        //
        textLabel = self.childNode(withName: "textLabel") as? SKLabelNode
        textLabel.name = "textLabelLabel"
        inputButton = self.childNode(withName: "inputButton") as? SKSpriteNode
        textLabel.color = UIColor.white
        newGameButtonNode.alpha = 1
        allScoreButtonNode.alpha = 1
        dollyHistoryNode.alpha = 1
        
        
        
        // Animation Background
        
        backgroundGif = self.childNode(withName: "gifBackground") as? SKSpriteNode
        animation = SKAction(named: "background")!
        
        backgroundGif.run(animation)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        touchButton = true
        
        if let location = touch?.location (in: self) {
            let nodesArray = self.nodes(at: location)
            if (nodesArray.first?.name == "newGameButton")
            {
                newGameButtonNode.alpha = 0.3
                let transition = SKTransition.fade(with: .black, duration: 0.5)
                //let gameScene = SKScene(fileNamed: "GameScene") as! GameScene
                
                let gameScene = GameScene(size:self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
            else if (nodesArray.first?.name == "allScoreButton")
            {
                allScoreButtonNode.alpha = 0.3
                let transition = SKTransition.fade(with: .black, duration: 0.5)
                let returnToMenuScene = SKScene(fileNamed: "ScoreScene") as! ScoreScene
                self.view?.presentScene(returnToMenuScene, transition: transition)
            }
            
            else if (nodesArray.first?.name == "historyDollyButton")
            {
                dollyHistoryNode.alpha = 0.3
                let transitionHistory = SKTransition.fade(with: .black, duration: 0.5)
                let historyScene = SKScene(fileNamed: "HistoryScene") as! HistoryScene
                self.view?.presentScene(historyScene, transition: transitionHistory)
            }
            
            else if (nodesArray.first?.name == "inputButton" || nodesArray.first?.name == "textLabelLabel")
            {
                textLabel.color = UIColor.white
                self.inputButton.alpha = 0.3
                self.textLabel.alpha = 0.3
                switch countTouch
                {
                case 1:
                    textLabel.text = "PAD"
                    chooseInput = 1
                    textLabel.color = UIColor.white
                    break
                case 2:
                    textLabel.text = "SWIPE"
                   
                    chooseInput = 2
                    textLabel.color = UIColor.white
                    
                    break
                default:
                    textLabel.text = "BUTTON"
                    
                    countTouch = 0
                    chooseInput = 0
                    textLabel.color = UIColor.white
                    break
                }
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.inputButton.alpha = 1
        self.textLabel.alpha = 1
        self.countTouch += 1
        print(countTouch)
        textLabel.color = UIColor.white
    }
}

