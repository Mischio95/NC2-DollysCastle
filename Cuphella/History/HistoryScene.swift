//
//  HistoryScene.swift
//  Cuphella
//
//  Created by Michele Trombone  on 14/12/22.
//


import SpriteKit


class HistoryScene: SKScene
{
    
    var mainMenuNode: SKSpriteNode!
    var dollyAnimation: SKSpriteNode!
    var animation: SKAction!
    
    override func didMove(to view: SKView) {
      
        mainMenuNode = self.childNode(withName: "returnToMenu") as? SKSpriteNode
        dollyAnimation = self.childNode(withName: "dolly") as? SKSpriteNode
        animation = SKAction(named: "dollyHistoryAnimation")
        dollyAnimation.run(animation)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        
        if let location = touch?.location (in: self)
        {
            let nodesArray = self.nodes(at: location)
            if(nodesArray.first?.name == "returnToMenu")
            {
                let transition = SKTransition.fade(with: .black, duration: 0.5)
                let returnToMenuScene = SKScene(fileNamed: "MenuScene") as! MenuScene
                self.view?.presentScene(returnToMenuScene, transition: transition)
            }
                 
         }
    }
}
