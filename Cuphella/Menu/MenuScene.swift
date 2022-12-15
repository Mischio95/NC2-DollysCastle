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
    var vibrationNode:SKSpriteNode!
    var vibrationOnOffLabel :SKLabelNode!
    var backgroundGif: SKSpriteNode!
    var animation: SKAction!
    var secondTouch = false
    
    override func didMove(to view: SKView)
    {
        newGameButtonNode = self.childNode(withName: "newGameButton") as? SKSpriteNode
        allScoreButtonNode = self.childNode(withName: "allScoreButton") as? SKSpriteNode
        dollyHistoryNode = self.childNode(withName: "historyDollyButton") as? SKSpriteNode
//        vibrationNode = self.childNode(withName: "vibrationButton") as? SKSpriteNode
//
//        vibrationOnOffLabel = self.childNode(withName: "vibrationOnOffLabel") as? SKLabelNode
        
        
        
        // Animation Background
        
        backgroundGif = self.childNode(withName: "gifBackground") as? SKSpriteNode
        animation = SKAction(named: "background")!

        backgroundGif.run(animation)
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        
        if let location = touch?.location (in: self) {
            let nodesArray = self.nodes(at: location)
            if (nodesArray.first?.name == "newGameButton")
            {
                let transition = SKTransition.fade(with: .black, duration: 0.5)
                //let gameScene = SKScene(fileNamed: "GameScene") as! GameScene
                let gameScene = GameScene(size:self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
            else if (nodesArray.first?.name == "allScoreButton")
            {
                let transition = SKTransition.fade(with: .black, duration: 0.5)
                let returnToMenuScene = SKScene(fileNamed: "ScoreScene") as! ScoreScene
                self.view?.presentScene(returnToMenuScene, transition: transition)
            }
            
            else if (nodesArray.first?.name == "historyDollyButton")
            {
                let transitionHistory = SKTransition.fade(with: .black, duration: 0.5)
                let historyScene = SKScene(fileNamed: "HistoryScene") as! HistoryScene
                self.view?.presentScene(historyScene, transition: transitionHistory)
                
            }
            
           
        }
    }
}
