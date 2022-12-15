//
//  StartGameScene.swift
//  Cuphella
//
//  Created by Michele Trombone  on 09/12/22.
//

import Foundation
import SpriteKit

class StartGameScene: SKScene
{
    var background = SKSpriteNode(imageNamed: "forest")
    
    let timerNode : SKLabelNode = SKLabelNode(fontNamed: "Arial-BoldMT")
    var time : Int = 5
    {
        didSet
        {
            if(time >= 4)
            {
                timerNode.text = "Time: \(time)"
            }
            else
            {
                timerNode.text = "0\(time)"
            }
        }
    }
    
    override func didMove (to view: SKView) -> Void
    {
        DispatchQueue.main.async
        {
            self.background.zPosition = 1
            self.background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            self.background.size = CGSize(width: self.size.width, height: self.size.height)
            self.addChild(self.background)
        }
        
        addChild(timerNode)
        time = 4 // force didset
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(countdown),SKAction.wait(forDuration: 1)])))
    }
    
    private func countdown()
    {
        time -= 1
        if(time <= 0)
        {
            GameScene()
        }
    }
}


