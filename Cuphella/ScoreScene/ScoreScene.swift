//
//  ScoreScene.swift
//  Cuphella
//
//  Created by Michele Trombone  on 09/12/22.
//

import Foundation
import SpriteKit

class ScoreScene: SKScene
{
    let scores = LoadScore()
    
    var scoreLabel1: SKLabelNode!
    var scoreLabel2: SKLabelNode!
    var scoreLabel3: SKLabelNode!
    var scoreLabel4: SKLabelNode!
    
    var mainMenuButton: SKSpriteNode!
    var newGameButton: SKSpriteNode!
    
    override func didMove (to view: SKView) -> Void
    {
        
        mainMenuButton = self.childNode(withName: "returnToMewnu") as? SKSpriteNode
        newGameButton = self.childNode(withName: "newGameButton") as? SKSpriteNode
        
        if !scores.isEmpty
        {
            for index in scores.indices
            {
                if (index == 0)
                {
                    scoreLabel1 = self.childNode(withName: "scoreLabel1") as? SKLabelNode
                    scoreLabel1?.text = "\(scores[index])"
                }
                
                else if (index == 1)
                {
                    scoreLabel2 = self.childNode(withName: "scoreLabel2") as? SKLabelNode
                    scoreLabel2?.text = "\(scores[index])"
                }
                
                else if (index == 2)
                {
                    scoreLabel3 = self.childNode(withName: "scoreLabel3") as? SKLabelNode
                    scoreLabel3?.text = "\(scores[index])"
                    
                }
                else if (index == 3)
                {
                    scoreLabel4 = self.childNode(withName: "scoreLabel4") as? SKLabelNode
                    scoreLabel4?.text = "\(scores[index])"
                }
            }
        }
    }
    

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            
            if let location = touch?.location (in: self)
            {
                let nodesArray = self.nodes(at: location)
                if (nodesArray.first?.name == "newGameButton")
                {
                    self.newGameButton.alpha = 0.3
                    let transition = SKTransition.fade(with: .black, duration: 0.5)
                    let gameScene = GameScene(size:self.size)
                    self.view?.presentScene(gameScene, transition: transition)
                }
                else if(nodesArray.first?.name == "returnToMenu")
                {
                    self.mainMenuButton.alpha = 0.3
                    let transition = SKTransition.fade(with: .black, duration: 0.5)
                    let returnToMenuScene = SKScene(fileNamed: "MenuScene") as! MenuScene
                    self.view?.presentScene(returnToMenuScene, transition: transition)
                }
                      //restart()
             }
        }

}
