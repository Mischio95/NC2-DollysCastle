//
//  SettingScene.swift
//  Cuphella
//
//  Created by Michele Trombone  on 17/12/22.
//

import Foundation
import SpriteKit

class SettingScene: SKScene
{
    
    
    var countTouch = 1
    var touchButton = false
    var touchSound = false
    var touchVibration = false
    
    var inputButton: SKSpriteNode!
    var textLabel: SKLabelNode!
    var textInfoInputLabel: SKLabelNode!
    
    var vibrationButtonNode: SKSpriteNode!
    var textVibrationButtonLabel: SKLabelNode!
    
    var soundButtonNode: SKSpriteNode!
    var textSoundButtonLabel:SKLabelNode!
    
    var textInfoInputLabelSecondLine: SKLabelNode!
    var dollyAnimationSprite:SKSpriteNode!
    var animation:SKAction!
    override func didMove(to view: SKView) {
        
        //Input
        
        textLabel = self.childNode(withName: "textLabel") as? SKLabelNode
        textLabel.name = "textLabelLabel"
        textLabel.color = UIColor.white
        inputButton = self.childNode(withName: "inputButton") as? SKSpriteNode
        textInfoInputLabel = self.childNode(withName: "descriptionInput") as? SKLabelNode
        textInfoInputLabel.color = UIColor.white
        textInfoInputLabel.zPosition = 20
        textInfoInputLabelSecondLine = self.childNode(withName: "textInfoInputLabelSecondLine") as? SKLabelNode
        
        //Vibration
        
        vibrationButtonNode = self.childNode(withName: "vibrationButton") as? SKSpriteNode
        textVibrationButtonLabel = self.childNode(withName: "textVibrationButton") as? SKLabelNode
        
        //Sound
        
        soundButtonNode = self.childNode(withName: "soundButton") as? SKSpriteNode
        textSoundButtonLabel = self.childNode(withName: "textSoundButton") as? SKLabelNode
        animation = SKAction(named: "dollyFaceAnimation")
        dollyAnimationSprite = self.childNode(withName: "dollyAnimation") as? SKSpriteNode
        dollyAnimationSprite.run(animation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        touchButton = true
        
        if let location = touch?.location (in: self)
        {
            let nodesArray = self.nodes(at: location)
            
            if (nodesArray.first?.name == "inputButton" || nodesArray.first?.name == "textLabelLabel")
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
                    textInfoInputLabel.text = "Click arrow direction to move dolly"
                    textInfoInputLabelSecondLine.text = "in up, down, right and left direction"
                    break
                case 2:
                    textLabel.text = "SWIPE"
                    chooseInput = 2
                    textLabel.color = UIColor.white
                    textInfoInputLabel.text = "Use swipe gesture on screen"
                    textInfoInputLabelSecondLine.text = "to move dolly such as --> "
                    break
                default:
                    textLabel.text = "BUTTON"
                    countTouch = 0
                    chooseInput = 0
                    textInfoInputLabel.text = "Choose direction with swipe gesture"
                    textInfoInputLabelSecondLine.text = "and click the button to move dolly"
                    
                    break
                }
            }
            
            else if (nodesArray.first?.name == "soundButton" || nodesArray.first?.name == "textSoundButton")
            {
               
                self.soundButtonNode.alpha = 0.3
                self.textSoundButtonLabel.alpha = 0.3
                
                if textSoundButtonLabel.text == "ON"
                {
                    print("false")
                    textSoundButtonLabel.text = "OFF"
                    chooseSound = false
                }
                
                else if textSoundButtonLabel.text == "OFF"
                {
                    print("true")
                    textSoundButtonLabel.text = "ON"
                    chooseSound = true
                }
                
            }
            
            else if (nodesArray.first?.name == "vibrationButton" || nodesArray.first?.name == "textVibrationButton")
            {
                self.vibrationButtonNode.alpha = 0.3
                self.textVibrationButtonLabel.alpha = 0.3
                
                if textVibrationButtonLabel.text == "ON"
                {
                    print("false")
                    textVibrationButtonLabel.text = "OFF"
                    chooseVibration = false
                }
                
                else if textVibrationButtonLabel.text == "OFF"
                {
                    print("true")
                    textVibrationButtonLabel.text = "ON"
                    chooseVibration = true
                }
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // SOUND
        
        self.textSoundButtonLabel.alpha = 1
        self.soundButtonNode.alpha = 1
        
        // VIBRATION
    
        self.vibrationButtonNode.alpha = 1
        self.textVibrationButtonLabel.alpha = 1
        
        // INPUT
        
        self.inputButton.alpha = 1
        self.textLabel.alpha = 1
        self.countTouch += 1
        print(countTouch)
        textLabel.color = UIColor.white
    }
}
