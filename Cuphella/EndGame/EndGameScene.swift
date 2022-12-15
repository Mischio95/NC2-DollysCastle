//
//  EndGameScene.swift
//  Cuphella
//
//  Created by Michele Trombone  on 08/12/22.
//

import Foundation
import SpriteKit
import UIKit


class EndGameScene: SKScene
{
    
    var score: Int = 0
    var touched = false
    
    var scoreLabel: SKLabelNode!
    var newGameButton: SKSpriteNode!
    
    let gameOverSound = SKAudioNode(fileNamed: "game-over-8bit.wav")
    var stopSound = false
    
    var backgroundGif: SKSpriteNode!
    var animation: SKAction!
    
    override func didMove (to view: SKView) -> Void
    {
    
        scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        scoreLabel.text = "\(score)"
        
        newGameButton = self.childNode(withName: "newGameButton") as? SKSpriteNode
        newGameButton.texture = SKTexture(imageNamed: "NewGame")
    
        backgroundGif = self.childNode(withName: "gifBackgroundEndGame") as? SKSpriteNode
        animation = SKAction(named: "backgroundEndGame")!
        
        backgroundGif.run(animation)
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        
        if let location = touch?.location (in: self)
        {
            let nodesArray = self.nodes(at: location)
            if (nodesArray.first?.name == "newGameButton")
            {
                let transition = SKTransition.fade(with: .black, duration: 0.5)
                let gameScene = GameScene(size:self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
            else if(nodesArray.first?.name == "returnToMenu")
            {
                let transition = SKTransition.fade(with: .black, duration: 0.5)
                let returnToMenuScene = SKScene(fileNamed: "MenuScene") as! MenuScene
                self.view?.presentScene(returnToMenuScene, transition: transition)
            }
                  //restart()
         }
    }
}
