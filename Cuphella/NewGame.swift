//
//  EndGameScene.swift
//  Cuphella
//
//  Created by Michele Trombone  on 08/12/22.
//

import Foundation
import SpriteKit
import UIKit


class NewGame: SKScene
{
    
    var background = SKSpriteNode(imageNamed: "fores1")
    var score: Int = 0
    var touched = false
   
    
    override func didMove (to view: SKView) -> Void
    {
        
        // Background image
        
        DispatchQueue.main.async
        {
            self.background.zPosition = 0
            self.background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            self.background.size = CGSize(width: self.size.width, height: self.size.height)
            self.addChild(self.background)
        }
        
        let scoreNode = SKLabelNode (fontNamed:"Copperplate-Bold")
        scoreNode.fontSize = 30
        scoreNode.fontColor = .white
        scoreNode.zPosition = 1
        scoreNode.position.x = frame.midX
        scoreNode.position.y = frame.midY + 50
        scoreNode.text = "Score: \(score)"
        
        let endNode = SKLabelNode (fontNamed:"Copperplate-Bold")
        endNode.fontSize = 30
        endNode.fontColor = .white
        endNode.zPosition = 1
        endNode.position.x = frame.midX
        endNode.position.y = frame.midY + 10
        endNode.text = "Game Over"
        
        let restartNode = SKLabelNode (fontNamed:"Copperplate-Bold")
        restartNode.fontSize = 40
        restartNode.fontColor = .white
        restartNode.zPosition = 1
        restartNode.position.x = frame.midX
        restartNode.position.y = frame.midY - 50
        restartNode.text = "Restart"
        restartNode.name = "restartNode"
        
        
        addChild(scoreNode)
        addChild(endNode)
        addChild(restartNode)
        
        // in caso possiamo implementare ques'altra gestur invece del click
        
        
//        let pinchRecognized = UITouch(target: self, action: #selector(handlePinch))
//        self.view?.addGestureRecognizer(pinchRecognized)
    }
    
//    @objc
//    private func handlePinch(recognizer: UITouch)
//    {
//        if recognizer.state == .ended
//        {
//            restart()
//        }
//    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         for touch in touches {
              let location = touch.location(in: self)
              let touchedNode = atPoint(location)
              if touchedNode.name == "restartNode" {
                  restart()
              }
         }
    }
    
    private func restart()
    {
        let transition = SKTransition.fade(with: .black, duration: 0.5)
        let restartScene = GameScene()
        restartScene.size = CGSize (width: 300, height: 400)
        restartScene.scaleMode = .resizeFill
        self.view?.presentScene(restartScene, transition: transition)
    }
}
