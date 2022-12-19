//
//  LoadingScene.swift
//  Cuphella
//
//  Created by Michele Trombone  on 18/12/22.
//

import Foundation
import UIKit
import SpriteKit

class LoadingScene: SKScene
{
    var dollyAnimation: SKSpriteNode!
    var animation: SKAction!
    var text1Label = SKLabelNode(fontNamed: "PixeloidMono")
    var text2Label = SKLabelNode(fontNamed: "PixeloidMono")
    
    override func didMove(to view: SKView)
    {
        dollyAnimation = self.childNode(withName: "dollyAnimation") as? SKSpriteNode
        animation = SKAction(named: "dollyHistoryAnimation")
        dollyAnimation.run(animation)
        
//        text1Label = SKLabelNode(fontNamed: "PixeloidMono")
//        text1Label.text = "DOLLY'S"
//        text1Label.fontSize = 400
//        text1Label.position.x = frame.midX
//        text1Label.position.y = frame.midY
//        text1Label.color = UIColor.white
//        text1Label.zPosition = 30
//    
//        
//        self.text2Label.text = "CASTLE"
//        self.text2Label.fontSize = 20
//        self.text2Label.position.x = self.frame.midX
//        self.text2Label.position.y = self.frame.midY - 100
//        self.text2Label.color = UIColor.white
//        self.text2Label.zPosition = 30
//        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5)
        {
            let transition = SKTransition.fade(with: .black, duration: 0.5)
            let returnToMenuScene = SKScene(fileNamed: "MenuScene") as! MenuScene
            self.view?.presentScene(returnToMenuScene, transition: transition)
        }
    }
}
