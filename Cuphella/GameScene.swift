//
//  GameScene.swift
//  Cuphella
//
//  Created by Kiar on 06/12/22.
//minuto 52 https://www.youtube.com/watch?v=fGJCb_oweG0

// TODO: Score

import SpriteKit
import UIKit
import Foundation




// METTERE I MURI QUANDO CE LI DANNO
// METTERE IL SOLE ANIMATIO, AGGIUSTARE BUG CHE SE CI PASSI NON RIPERDI VITA E NON SI RESETTA
// METTERE SETTING SCENE SE CE LA FACCIAMO
// AGGIUSTARE ASSSOLUTAMENTE LE FRECC


//DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { METTI QUA DENTRO QUELLO CHE DEVE ESSERE DELAYATIO }DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { METTI QUA DENTRO QUELLO CHE DEVE ESSERE DELAYATIO }

/*
 MAPPA:
 0 = Free Celle
 1 = Muri Interni
 2 = burnLight
 3 = Muro Orizzontale Alto
 4 = Muro Vertiale Sinistro
 5 = Muro Verticale Destro
 6 = Muro Orizzontale Basso
 7 = Prato Esterno di background
 8 = Interni Diversi
 9 = Celle per cambiare mappa
 */

class GameScene: SKScene
{
    
    var pipistrello: SKSpriteNode!
    
    var backgroundScene: SKSpriteNode!
    
    let directionPlayerSwipe = SKSpriteNode()
    
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    var vectorLight: [SKSpriteNode] = []
    
    var invincible = false
    
    //Various Animation

    let explosionBloodSprite = SKSpriteNode()
    
    private var explosionAtlas: SKTextureAtlas
    {
        return SKTextureAtlas(named: "blood")
    }
    
    private var explosionBlood: [SKTexture]
    {
        return [explosionAtlas.textureNamed("blood0"),
                explosionAtlas.textureNamed("blood1"),
                explosionAtlas.textureNamed("blood2"),
                explosionAtlas.textureNamed("blood3")]
    }
    
    private var TurnOnLightAtlas: SKTextureAtlas
    {
        return SKTextureAtlas(named: "TurnOnLight")
    }
    
    private var turnOnLight: [SKTexture]
    {
        return[TurnOnLightAtlas.textureNamed("casellailluminata1"),
               TurnOnLightAtlas.textureNamed("casellailluminata2"),
               TurnOnLightAtlas.textureNamed("casellailluminata3"),
               TurnOnLightAtlas.textureNamed("casellailluminata4"),
               TurnOnLightAtlas.textureNamed("casellailluminata5"),
               TurnOnLightAtlas.textureNamed("casellailluminata6")]
    }
    
    var dollySprite = SKSpriteNode(imageNamed: "Dollyperdevita1")
    
    private var dollyAtlas: SKTextureAtlas
    {
        return SKTextureAtlas(named: "DollyHit")
    }
    
    private var dollyHit: [SKTexture]
    {
        return[dollyAtlas.textureNamed("Dollyperdevita1"),
               dollyAtlas.textureNamed("Dollyperdevita2"),
               dollyAtlas.textureNamed("Dollyperdevita3"),
               dollyAtlas.textureNamed("Dollyperdevita4"),
               dollyAtlas.textureNamed("Dollyperdevita5"),
               dollyAtlas.textureNamed("Dollyperdevita6"),
               dollyAtlas.textureNamed("Dollyperdevita1")]
    }
    
    //Player
    var player: SKSpriteNode!
   
    
    //SceneObject
    var blood: SKSpriteNode!
   
    var ground: SKSpriteNode!
    
    let safeArea = SKSpriteNode()
    
    
    //GameManager
    var currentRound: Int = 1
    var points: [CGPoint] = [] //All CGPoint of the map
    var touched: Bool = false
    var totalScore = 0
    let backgroundMusic = SKAudioNode(fileNamed: "MysteriousDungeon.mp3")
    let gameOverSound = SKAudioNode(fileNamed: "game-over-8bit.wav")
    var cam: SKCameraNode!
    var newDirection: String = "down"
    var lastDirection: String = "down"
    let timerNode : SKLabelNode = SKLabelNode(fontNamed: "PixeloidMono")
    var background = SKSpriteNode (imageNamed: "fores1")
    let currentLifeLabelForTexture = SKSpriteNode(imageNamed: "FullHeart")
    var currentHeart: Int = 4
    var heldDownTouchAnimation = false
    var maxFreeCell: Int = 0
    var cellToOccupy: Int = 0
    var human: SKSpriteNode!
    
    // 7 angolo basso sinistro 8 angolo basso destro 10 angolo alto sinistro 11 angolo alto destro
    // 11 tetto centrale orizzontale 12 tetto centrale verticale
    //Maps
    
    
    var arrayTexture: [SKSpriteNode] = []//Texture of ground that can be changed
    var totalArrayTexture: [SKSpriteNode] = []//All texture of the ground
    var arrayBlood: [SKSpriteNode] = []//Array of blood that can be picked
    var totalArrayBlood: [SKSpriteNode] = []//All bloods on the map
    
    var arrayPoint: [[Int]] = [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                              [9,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1],
                              [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
                              [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
                              [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                              [1,0,1,1,1,0,1,0,1,1,1,1,1,0,1,0,1,1,1,0,1],
                              [1,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,1],
                              [1,0,1,0,1,0,1,1,1,0,1,0,1,1,1,0,1,0,1,0,1],
                              [1,0,1,0,1,0,1,0,0,0,0,0,0,0,1,0,1,0,1,0,1],
                              [1,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,1,0,1,0,1],
                              [1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,1],
                              [1,0,1,0,1,0,1,0,0,0,0,0,0,0,1,0,1,0,1,1,1],
                              [1,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,1,0,0,0,1],
                              [1,0,1,0,1,0,1,0,0,0,1,0,0,0,1,0,1,0,1,1,1],
                              [1,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,1],
                              [1,0,1,1,1,0,1,1,1,0,1,0,1,1,1,0,1,1,1,0,1],
                              [1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1],
                              [1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1],
                              [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                              [1,0,1,0,1,0,1,1,1,1,0,1,1,1,1,0,1,0,1,0,1],
                              [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                              [1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1],
                              [1,0,1,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,1,0,1],
                              [1,0,1,0,1,0,1,1,0,1,0,1,0,1,1,0,1,0,1,0,1],
                              [1,0,1,0,1,0,1,1,0,1,0,1,0,1,1,0,1,0,1,0,1],
                              [1,0,0,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,0,0,9],
                              [7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]]
    
    //HUD
    var currentLifeLable = SKLabelNode(fontNamed: "PixeloidMono")
    var currentLife: Int = 6
    {
        didSet
        {
            if(currentLife >= 5)
            {
                currentLifeLable.text = "\(currentLife)"
            }
            else
            {
                currentLifeLable.text = "0\(currentLife)"
            }
        }
    }
    
    var currentLifeVectorForTexture: [Int] = [6]
    
    var scoreLabel: SKLabelNode =
    {
        var label = SKLabelNode(fontNamed: "PixeloidMono")
        label.fontSize = CGFloat(20)
        label.zPosition = 30
        label.fontColor = UIColor.white
        label.text = "00"
        label.position = CGPoint(x: 300, y: 300)
        return label
    }()
    
    var time : Int = 10
    {
        didSet
        {
            if(time >= 10)
            {
                timerNode.text = "\(time)"
            }
            else
            {
                timerNode.text = "0\(time)"
            }
        }
    }
    var showedScore = UILabel()

    var touchUp: SKSpriteNode?
    var touchDown: SKSpriteNode?
    var touchLeft: SKSpriteNode?
    var touchRight: SKSpriteNode?
    var totalPlayerHeart: [SKSpriteNode] = []
    
    var hiddenTouchUp = SKSpriteNode(imageNamed: "Arrow")
    var hiddenTouchDown = SKSpriteNode(imageNamed: "Arrow")
    var hiddenTouchLeft = SKSpriteNode(imageNamed: "Arrow")
    var hiddenTouchRight = SKSpriteNode(imageNamed: "Arrow")
    

    
   
    
    
    //PlayerAnimation
    private var dollyDownAtlas: SKTextureAtlas
    {
        return SKTextureAtlas(named: "DollyMoveDown")
    }
    
    private var dollyUpAtlas: SKTextureAtlas
    {
        return SKTextureAtlas(named: "DollyMoveUp")
    }
    
    private var dollyLeftAtlas: SKTextureAtlas
    {
        return SKTextureAtlas(named: "DollyMoveLeft")
    }
    
    private var dollyRightAtlas: SKTextureAtlas
    {
        return SKTextureAtlas(named: "DollyMoveRight")
    }
    
    
    private var pipistrelloAtlas: SKTextureAtlas
    {
        return SKTextureAtlas(named: "PipistrelloAnimation")
    }
    
    private var pipistrelloMove: [SKTexture]
    {
        return[
         pipistrelloAtlas.textureNamed("batbat1"),
         pipistrelloAtlas.textureNamed("batbat2"),
         pipistrelloAtlas.textureNamed("batbat3"),
         pipistrelloAtlas.textureNamed("batbat4"),
         pipistrelloAtlas.textureNamed("batbat5"),
         pipistrelloAtlas.textureNamed("batbat6"),
         pipistrelloAtlas.textureNamed("batbat7")]
        
    }
    private var dollyMoveDown: [SKTexture]
    {
    
        return[
        dollyDownAtlas.textureNamed("DollyDown1"),
        dollyDownAtlas.textureNamed("DollyDown0"),
        dollyDownAtlas.textureNamed("DollyDown1")]
    }
    
    private var dollyMoveUp: [SKTexture]
    {
        return[
            dollyUpAtlas.textureNamed("DollyUp1"),
            dollyUpAtlas.textureNamed("DollyUp2"),
            dollyUpAtlas.textureNamed("DollyUp0")]
    }
    
    private var dollyMoveLeft: [SKTexture]
    {
        return[
            dollyLeftAtlas.textureNamed("DollyLeft1"),
            dollyLeftAtlas.textureNamed("DollyLeft2"),
            dollyLeftAtlas.textureNamed("DollyLeft0")]
    }
    
    private var dollyMoveRight: [SKTexture]
    {
        return[
            dollyRightAtlas.textureNamed("DollyRight2"),
            dollyRightAtlas.textureNamed("DollyRight3"),
            dollyRightAtlas.textureNamed("DollyRight1")]
    }
    
    private var dollyIdleDown: [SKTexture]
    {
        return[
        dollyDownAtlas.textureNamed("DollyDown0")]
    }
    
    private var dollyIdleUp: [SKTexture]
    {
        return[
        dollyUpAtlas.textureNamed("DollyUp0")]
    }
    
    private var dollyIdleLeft: [SKTexture]
    {
        return[
        dollyLeftAtlas.textureNamed("DollyLeft0")]
    }
    
    private var dollyIdleRight: [SKTexture]
    {
        return[
        dollyRightAtlas.textureNamed("DollyRight1")]
    }
    
    
    //EnemyAnimation
    private var enemyAtlas: SKTextureAtlas
    {
        return SKTextureAtlas(named: "EnemyAnimation")
    }
    
    private var enemyAnim: [SKTexture]
    {
        return[
            enemyAtlas.textureNamed("cattivo1"),
            enemyAtlas.textureNamed("cattivo2"),
            enemyAtlas.textureNamed("cattivo3"),
            enemyAtlas.textureNamed("cattivo4"),
            enemyAtlas.textureNamed("cattivo5"),
            enemyAtlas.textureNamed("cattivo6")]
    }
    
    
    override func didMove(to view: SKView)
    {
        
//        backgroundScene = self.childNode(withName: "forest") as? SKSpriteNode
//        backgroundScene.name = "forest"
        
        CreateMap()
        CreatePlayer()
        CreateHeart()
        
        // choosInput = 0 SANTOFRANCI INPUT, chooseInput = 1 BOTTONI, chooseInput = 2 SWIPE
        ChooseInput()
        
        //ScoreLabel
        scoreLabel.position.x = frame.midX
        scoreLabel.color = UIColor.black
        scoreLabel.position.y = frame.maxY / 1.2
        addChild(scoreLabel)
        
        // SafeArea
        safeArea.size = CGSize(width: 600, height: 50)
        safeArea.color = UIColor.black
        safeArea.alpha = 0.75
        safeArea.zPosition = scoreLabel.zPosition - 1
        addChild(safeArea)
        
        //Timer
        timerNode.fontSize = 30
        timerNode.zPosition = 30
        timerNode.position.x = frame.midX + 125
        timerNode.position.y = frame.maxY / 1.2
        addChild(timerNode)
        time = 10 // force didset
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(countdown),SKAction.wait(forDuration: 1)])))
        
        
        
        //Life
        currentLifeLable.fontSize = 30
        currentLifeLable.zPosition = 30
        currentLifeLable.position.x = frame.midX
        currentLifeLable.position.y = frame.midY
        addChild(currentLifeLable)
        currentLife = 6
        
        
        //Camera
        cam = SKCameraNode()
        cam.xScale = 0.4
        cam.yScale = 0.4
        addChild(cam)
        camera = cam
        
       
        dollySprite.zPosition = scoreLabel.zPosition - 1
        dollySprite.size = CGSize(width: 40, height: 40)
        dollySprite.name = "dollySprite"
        addChild(dollySprite)
        
     
        
        // Blood
        addChild(explosionBloodSprite)

// -------------- INPUT TYPE --------------


  
        self.view?.isMultipleTouchEnabled = false
        //MUSIC
        addChild(backgroundMusic)
        backgroundMusic.run(SKAction.changeVolume(to: Float(0.1), duration: 0))
    
    }

    
    
    
    override func update(_ currentTime: TimeInterval)
    {
        
        //addSwipeGesture()
//        backgroundScene.position = player.position
//        backgroundScene.zPosition = player.zPosition - 1000
//        backgroundScene.name = "0"
        
        cam.position.x = player.position.x
        cam.position.y = player.position.y
        
       
        timerNode.position.x = cam.position.x + 75
        timerNode.position.y = cam.position.y + 170
        
        var actualPosition = CGPoint(x:  cam.position.x - 75, y:  cam.position.y + 170)
        
        for i in 0..<totalPlayerHeart.count
        {
            actualPosition.x = actualPosition.x + 15
            //actualPosition.y = actualPosition.y + CGFloat(i)+1 * 10
            totalPlayerHeart[i].position.x = actualPosition.x + 30
            totalPlayerHeart[i].position.y = actualPosition.y - 30
        }
        
        scoreLabel.position.x = cam.position.x + 60
        scoreLabel.position.y = cam.position.y + 130
        
        //
        currentLifeLable.position.x = cam.position.x + 1
        currentLifeLable.position.y = cam.position.y + 170
        
        safeArea.position.x = scoreLabel.position.x
        safeArea.position.y = scoreLabel.position.y + 15
        
        dollySprite.position.x = totalPlayerHeart[0].position.x - 30
        dollySprite.position.y = totalPlayerHeart[0].position.y
        
        touchUp?.position.x = cam.position.x + 0.1
        touchUp?.position.y = cam.position.y - 90
    
        touchDown?.position.x = cam.position.x + 0.1
        touchDown?.position.y = cam.position.y - 140
        
       
        touchLeft?.position.x = cam.position.x - 30
        touchLeft?.position.y = cam.position.y - 114

        touchRight?.position.x = cam.position.x + 30
        touchRight?.position.y = cam.position.y - 114
        
        pipistrello?.position.x = cam.position.x
        pipistrello?.position.y = cam.position.y - 110
    }
}

//MARK: Map
extension GameScene
{
    func CreateMap()
    {
       // ResetArray()
       
        var x: CGFloat = self.size.width/2 + self.size.width/CGFloat(arrayPoint[0].count)/2
        //var y: CGFloat = self.size.width/2 - self.size.width/CGFloat(arrayPoint[0].count)/2
        var y: CGFloat = self.size.width - self.size.width/CGFloat(arrayPoint[0].count) - 300
        
        for i in 0...arrayPoint.count-1
        {
            x = self.size.width/2 + self.size.width/CGFloat(arrayPoint[0].count)
            
            if(i == 0)
            {
               // y =  self.size.width/2 - self.size.width/CGFloat(arrayPoint[0].count)/2
                y =  self.size.width - self.size.width/CGFloat(arrayPoint[0].count) / 2
            }
            else
            {
                y -= self.size.width/CGFloat(arrayPoint[0].count)
            }
            
            for j in 0...arrayPoint[0].count-1
            {
                ground = SKSpriteNode()
                ground.size = CGSize(width: self.size.width/CGFloat(arrayPoint[0].count),
                                     height: self.size.width/CGFloat(arrayPoint[0].count))
                
                if(arrayPoint[i][j] == 0)
                {
                    blood = SKSpriteNode(imageNamed: "blood")
                    blood.size = CGSize(width: 11, height: 11)
                    blood.zRotation = 0.19
                    blood.name = "redBloodCell"
                    blood.zPosition = 3
                    ground.name = "0"
                    ground.texture = SKTexture(imageNamed: "DarkBrick")
                    arrayTexture.append(ground)
                    totalArrayTexture.append(ground)
                    ground.size = CGSize(width: self.size.width/CGFloat(arrayPoint[0].count),
                                         height: self.size.width/CGFloat(arrayPoint[0].count))
                    ground.zPosition = 1
                    ground.addChild(blood)
                    arrayBlood.append(blood)
                    totalArrayBlood.append(blood)
                    maxFreeCell += 1
                }
                else if(arrayPoint[i][j] == 1)
                {
                    ground.name = "1"
                    ground.texture = SKTexture(imageNamed: "wallt")
                    ground.size = CGSize(width: self.size.width/CGFloat(arrayPoint[0].count),
                                         height: self.size.width/CGFloat(arrayPoint[0].count))
                }
                
                ground.position = CGPoint(x: x, y: y)
                x += self.size.width/CGFloat(arrayPoint[0].count)
                addChild(ground)
                points.append(ground.position)
            }
        }
    }
}

//MARK: Player
extension GameScene
{
    func CreatePlayer()
    {
        player = SKSpriteNode(imageNamed: "DollyDown0")
        player.zPosition = 20
        player.size = CGSize(width: 25, height: 25)
        player.name = "Player"
        player.position = points[481]
        addChild(player)
    }
    
    func MovePlayer(x: CGFloat, y: CGFloat)
    {
        if(touched)
        {
            let next = nodes(at: CGPoint(x: player.position.x + x, y: player.position.y + y)).last
            if(next?.name == "0" || next?.name == "2" || next?.name == "ciccio")
            {
                if(next?.name == "2")
                {
                    
                    if !invincible
                    {
                        let burnLight = SKAction.playSoundFileNamed("burn.wav", waitForCompletion: false)
                               run(burnLight)
                        PlayerHit()
                        UpdateLife()
                    }
                }

                if(next?.childNode(withName: "redBloodCell") != nil)
                {
                    next?.childNode(withName: "redBloodCell")?.removeFromParent()
                    totalScore += 1
                    if totalScore % 20 == 0
                    {
                        AddLife()
                    }
                    UpdateScore()
                }
                
                if(next?.childNode(withName: "human") != nil)
                {
                    explosionBloodSprite.position = next!.position
                    explosionBloodSprite.alpha = 1
                    
                    explosionBloodSprite.zPosition = player.zPosition - 1
                    explosionBloodSprite.size = CGSize(width: 80, height: 80)
                    
                    let explosionBloodAnimation = SKAction.animate(with: explosionBlood,timePerFrame: 0.09)
                    explosionBloodSprite.run(explosionBloodAnimation)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2)
                    {
                        self.explosionBloodSprite.alpha = 0
                    }
                    
                    // riproduce suono una sola volta
                    let vampireBite = SKAction.playSoundFileNamed("VampireBite.wav", waitForCompletion: false)
                           run(vampireBite)
                    
                    next?.childNode(withName: "human")?.removeFromParent()
                        
                    AddLife()
                }
        
                player.position = next!.position
                StarRunningAnimation()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(130))
                {
                    [self] in
                    MovePlayer(x: x, y: y)
                }
            }
            
            else if (next?.name == "1")
            {
                StartIdleAnimation()
            }
        }
        
    }
    
    func PlayerHit()
    {
        // animation fade when touch light
        let fadePlayerAction = SKAction.fadeOut(withDuration: 0.3)
        let fadePlayerActionReversed = fadePlayerAction.reversed()
        let fadePlayerSequence = SKAction.sequence([fadePlayerAction, fadePlayerActionReversed,fadePlayerAction,fadePlayerActionReversed,fadePlayerAction,fadePlayerActionReversed])
        
        player.run(fadePlayerSequence)
        
        invincible = true
        
        RemoveHeart()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)
        {
            self.invincible = false
        }
        
        dollySpriteAnimation()
    }
    
    func UpdateScore()
    {
        scoreLabel.text = "\(totalScore)"
    }
    
    func UpdateLife()
    {
        currentLifeLable.text = "\(currentLife)"
    }
}

//MARK: Inupt
extension GameScene
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        if(atPoint(location).name == "left" || atPoint(location).name == "left1")
        {
            selectionFeedbackGenerator.selectionChanged()
            touched = true
            childNode(withName: "left")?.alpha = 1
            newDirection = "left"
            MovePlayer(x: -self.size.width/CGFloat(arrayPoint[0].count), y: 0)
        }
        else if(atPoint(location).name == "up" || atPoint(location).name == "up1")
        {
            selectionFeedbackGenerator.selectionChanged()
            touched = true
            childNode(withName: "up")?.alpha = 1
            newDirection = "up"
            MovePlayer(x: 0, y: self.size.width/CGFloat(arrayPoint[0].count))
        }
        else if(atPoint(location).name == "down" || atPoint(location).name == "down1")
        {
            selectionFeedbackGenerator.selectionChanged()
            touched = true
            childNode(withName: "down")?.alpha = 1
            newDirection = "down"
            MovePlayer(x: 0, y: -self.size.width/CGFloat(arrayPoint[0].count))
        }
        else if(atPoint(location).name == "right" || atPoint(location).name == "right1")
        {
            selectionFeedbackGenerator.selectionChanged()
            touched = true
            childNode(withName: "right")?.alpha = 1
            newDirection = "right"
            MovePlayer(x: self.size.width/CGFloat(arrayPoint[0].count), y: 0)
        }
        
        else if(atPoint(location).name == "dollySprite")
        {
            let transition = SKTransition.fade(with: .black, duration: 0.5)
            let returnToMenuScene = SKScene(fileNamed: "MenuScene") as! MenuScene
            self.view?.presentScene(returnToMenuScene, transition: transition)
        }
        
// ----------------------------------------------------- PIPISTRELLO BUTTON -------------------------------
        
        else if(atPoint(location).name == "pipistrello" && newDirection == "up")
        {
            selectionFeedbackGenerator.selectionChanged()
            touched = true
            newDirection = "up"
            pipistrello?.alpha = 1
            MovePlayer(x: 0, y: self.size.width/CGFloat(arrayPoint[0].count))
        }
        
        else if(atPoint(location).name == "pipistrello" && newDirection == "down")
        {
            selectionFeedbackGenerator.selectionChanged()
            touched = true
            newDirection = "down"
            pipistrello?.alpha = 1
            MovePlayer(x: 0, y: -self.size.width/CGFloat(arrayPoint[0].count))
        }
        
        else if(atPoint(location).name == "pipistrello" && newDirection == "right")
        {
            selectionFeedbackGenerator.selectionChanged()
            touched = true
            newDirection = "right"
            pipistrello?.alpha = 1
            MovePlayer(x: self.size.width/CGFloat(arrayPoint[0].count), y: 0)
        }
        
        else if(atPoint(location).name == "pipistrello" && newDirection == "left")
        {
            selectionFeedbackGenerator.selectionChanged()
            touched = true
            newDirection = "left"
            pipistrello?.alpha = 1
            MovePlayer(x: -self.size.width/CGFloat(arrayPoint[0].count), y: 0)
        }
        
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for child in children
        {
            if(child.name == "left" || child.name == "up" || child.name == "down" || child.name == "right")
            {
                if(child.name == "left" || child.name == "up" || child.name == "down" || child.name == "right")
                {
                    child.alpha = 0.8
                }
            }
        }
        touched = false
        pipistrello?.alpha = 0.8
        StartIdleAnimation()
            
    }

// ------------------------------------------- SWIPE TYPE PACMAN  -------------------------------------------------------------
        
    func addSwipeGesture()
        {
            let swipeRight : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedRight))

                swipeRight.direction = .right

                view?.addGestureRecognizer(swipeRight)

            let swipeDown : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedDown))

                swipeDown.direction = .down

                view?.addGestureRecognizer(swipeDown)

            let swipeUp : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedUp))

                swipeUp.direction = .up

                view?.addGestureRecognizer(swipeUp)

            let swipeLeft : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedLeft))

                swipeLeft.direction = .left

                view?.addGestureRecognizer(swipeLeft)
        }

        @objc func swipedRight(sender: UISwipeGestureRecognizer) {

            touched = true
            newDirection = "right"
            MovePlayer(x: self.size.width/CGFloat(arrayPoint[0].count), y: 0)
            StartIdleAnimation()
          }

        @objc func swipedUp(sender: UISwipeGestureRecognizer) {

            touched = true
            newDirection = "up"
            MovePlayer(x: 0, y: self.size.width/CGFloat(arrayPoint[0].count))
            StartIdleAnimation()
          }

        @objc func swipedDown(sender: UISwipeGestureRecognizer) {

            touched = true
            newDirection = "down"
            
            MovePlayer(x: 0, y: -self.size.width/CGFloat(arrayPoint[0].count))
            StartIdleAnimation()
          }

        @objc func swipedLeft(sender: UISwipeGestureRecognizer) {

            touched = true
            newDirection = "left"
            MovePlayer(x: -self.size.width/CGFloat(arrayPoint[0].count), y: 0)
            StartIdleAnimation()
          }
    
    
// ------------------------------------------- SANTO E FRANCI INPUT -------------------------------------------------------------
    
    func addSantoFranciSwipeButton()
    {
        let swipeRight : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedRightSantoFranci))

            swipeRight.direction = .right

            view?.addGestureRecognizer(swipeRight)

        let swipeDown : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedDownSantoFranci))

            swipeDown.direction = .down

            view?.addGestureRecognizer(swipeDown)

        let swipeUp : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedUpSantoFranci))

            swipeUp.direction = .up

            view?.addGestureRecognizer(swipeUp)

        let swipeLeft : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedLeftSantoFranci))

            swipeLeft.direction = .left

            view?.addGestureRecognizer(swipeLeft)
    }
    
    @objc func swipedRightSantoFranci(sender: UISwipeGestureRecognizer) {
        
        newDirection = "right"
        //pipistrello.zRotation = -1.5708
        touched = false
        StartIdleAnimation()
      }

    @objc func swipedUpSantoFranci(sender: UISwipeGestureRecognizer) {

        newDirection = "up"
        //pipistrello.zRotation = 0
        touched = false
        StartIdleAnimation()
      }

    @objc func swipedDownSantoFranci(sender: UISwipeGestureRecognizer) {

        newDirection = "down"
        //pipistrello.zRotation = -3.14159
        touched = false
        StartIdleAnimation()
        
      }

    @objc func swipedLeftSantoFranci(sender: UISwipeGestureRecognizer) {

        newDirection = "left"
        //pipistrello.zRotation = 1.5708
        touched  = false
        StartIdleAnimation()
        
      }
}

//MARK: Timer
extension GameScene
{
    private func countdown()
    {
        time -= 1
        
        if(time <= 0)
        {
            NewRound()
        }
        
        if(time % 2 == 0)
        {
            for i in 0...cellToOccupy
            {
                if(i <= cellToOccupy)
                {
                    ReduceWalkingCell()
                }
                else
                {
                    break
                }
            }
        }
        
        if(time % 5 == 0)
        {
            CreateHumanBuff()
        }
        
        if(time % 7 == 0)
        {
            RemoveHeart()
            dollySpriteAnimation()
        }
    }
}


    
//MARK: GAMEMANAGER
extension GameScene
{
    func ReduceWalkingCell()
    {
        var spawnOnPlayer = true
        
        //Debug
        if(arrayTexture.isEmpty)
        {
            print("freeCelPositionisEmpty")
        }
        else
        {
            var randomInt = Int.random(in: 0...arrayTexture.count-1)
            
            
            //light.position = tempSprite.position
        
            while(spawnOnPlayer)
            {
                if(arrayTexture[randomInt].position != player.position)
                {
                    spawnOnPlayer = false
                }
                else
                {
                    randomInt = Int.random(in: 0...arrayTexture.count-1)
                }
            }
            arrayTexture[randomInt].name = "2"
            arrayTexture[randomInt].texture = SKTexture(imageNamed: "BrickLightOn")
            arrayTexture[randomInt].size = CGSize(width: self.size.width/CGFloat(arrayPoint[0].count),
                                                  height: self.size.width/CGFloat(arrayPoint[0].count))
            arrayTexture.remove(at: randomInt)
        }
    }
    
    private func EndGame()
    {
        //addChild(gameOverSound)
        UpdateHightScore(with: totalScore)
        let transition = SKTransition.fade(with: .black, duration: 0.5)
        let restartScene = SKScene(fileNamed: "EndGameScene") as! EndGameScene
        restartScene.score = self.totalScore
        ResetArray()
        self.view?.presentScene(restartScene, transition: transition)
    }
    
    func NewGame()
    {
        let transition = SKTransition.fade(with: .black,duration: 0.5)
        let menuScene = MenuScene()
        menuScene.size = CGSize(width: 300, height: 400)
        menuScene.scaleMode = .fill
        self.view?.presentScene(menuScene, transition: transition)
    }
    
    
    func ChooseInput()
    {
        if chooseInput == 0
        {
            // -------------- FRANCI E SANTO MOVMENT --------------
            
            createPipistrelloButton()
            addSantoFranciSwipeButton()
        }
        else if chooseInput == 1
        {
            // -------------- BOTTONI --------------
                    
            CreateInput()
        }
        else if chooseInput == 2
        {
            // -------------- SWIPE TIPO PACMAN FINO AD OSTACOLI E SI FERMA CON UN CLICK --------------
            
            addSwipeGesture()
        }
        
        
                
        

                
                
        
                
               
    }
    
    func CreateInput()
    {
        touchUp = SKSpriteNode(imageNamed: "Arrow")
        touchUp?.size = CGSize(width: 35, height: 35)
        touchUp?.name = "up"
        touchUp?.zPosition = 100
        addChild(touchUp!)
        
        
        touchDown = SKSpriteNode(imageNamed: "Arrow")
        touchDown?.size = CGSize(width: 35, height: 35)
        touchDown?.name = "down"
        touchDown?.zRotation = -3.14159
        touchDown?.zPosition = 100
        addChild(touchDown!)
        
        touchLeft = SKSpriteNode(imageNamed: "Arrow")
        touchLeft?.size = CGSize(width: 35, height: 35)
        touchLeft?.name = "left"
        touchLeft?.zRotation = 1.5708
        touchLeft?.zPosition = 100
        addChild(touchLeft!)

        touchRight = SKSpriteNode(imageNamed: "Arrow")
        touchRight?.size = CGSize(width: 35, height: 35)
        touchRight?.name = "right"
        touchRight?.zRotation = -1.5708
        touchRight?.zPosition = 100
        addChild(touchRight!)
    }
    
    func createPipistrelloButton()
    {
        pipistrello = SKSpriteNode(imageNamed: "pipistrello")
        pipistrello?.size = CGSize(width: 80, height: 80)
        pipistrello?.name = "pipistrello"
        pipistrello?.alpha = 0.7
        pipistrello?.zPosition = 100
        let pipistrelloAnimation = SKAction.animate(with: pipistrelloMove, timePerFrame: 0.1)
        pipistrello.run(SKAction.repeatForever(pipistrelloAnimation))
        addChild(pipistrello!)
    }
    
    
    
    func ResetArray()
    {
        for i in 1...arrayPoint.count-2
        {
            for j in 1...arrayPoint.count-2
            {
                if(!arrayPoint.isEmpty)
                {
                    if(j >= 21)
                    {
                        break
                    }
                    if(arrayPoint[i][j] != 1)
                    {
                        arrayPoint[i][j] = 0
                    }
                }
            }
        }
    }
    
    func NewRound()
    {
        print("new round")
        currentRound += 1
        time = 10
        cellToOccupy += currentRound * 2
        ResetAllPosition()
    }
    

    func ResetAllPosition()
    {
        for i in 0...totalArrayTexture.count-1
        {
            totalArrayTexture[i].texture = SKTexture(imageNamed: "DarkBrick")
            totalArrayTexture[i].name = "0"
            totalArrayTexture[i].size = CGSize(width: self.size.width/CGFloat(arrayPoint[0].count),
                                               height: self.size.width/CGFloat(arrayPoint[0].count))
            arrayTexture.append(totalArrayTexture[i])
        }
    }
    
    func addBackground()
    {
        DispatchQueue.main.async
        {
            self.background.zPosition = 1
            self.background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            self.background.size = CGSize(width: self.size.width, height: self.size.height)
            self.addChild(self.background)
        }
    }
    
    func CreateHeart()
    {
        var position: CGPoint?
        position?.x = 50
        position?.y = 50
        for _ in 0...currentHeart
        {
            let newHeart = SKSpriteNode(imageNamed: "cuore")
            newHeart.size = CGSize(width: 20, height: 20)
            newHeart.zPosition = 30
            newHeart.position = player.position
            totalPlayerHeart.append(newHeart)
            addChild(newHeart)
        }
    }
    
    func AddHeart()
    {
        if(currentHeart < 4)
        {
            currentHeart += 1
            totalPlayerHeart[currentHeart].texture = SKTexture(imageNamed: "cuore")
            
        }
    }
    
    func RemoveHeart()
    {
        if(currentHeart > 0)
        {
            totalPlayerHeart[currentHeart].texture = SKTexture(imageNamed: "DALL·E 2022-12-07 15.18.33 - human hearth pixelart")
            currentHeart -= 1
        }
        else
        {
            EndGame()
        }
    }
    
  

}

//MARK: PLAYER ANIMATION
extension GameScene
{
    func StarRunningAnimation()
    {
        switch newDirection
        {
        case "left": let moveLeft = SKAction.animate(with: dollyMoveLeft, timePerFrame: 0.09)
            player.run(SKAction.repeatForever(moveLeft), withKey: "dollyIdleLeft")
            break
            
        case "right": let moveRight = SKAction.animate(with: dollyMoveRight, timePerFrame: 0.09)
            player.run(SKAction.repeatForever(moveRight), withKey: "dollyRightIdle")
            break
            
        case "up": let moveUp = SKAction.animate(with: dollyMoveUp, timePerFrame: 0.09)
            player.run(SKAction.repeatForever(moveUp), withKey: "dollyUpIdle")
            break
            
        case "down": let moveDown = SKAction.animate(with: dollyMoveDown, timePerFrame: 0.09)
            player.run(SKAction.repeatForever(moveDown), withKey: "dollyDownIdle")
            break
            
        default:
            break
        }
    }
        
    func StartIdleAnimation()
    {
        switch newDirection
        {
        case "left": let idleLeft = SKAction.animate(with: dollyIdleLeft, timePerFrame: 0.1)
            player.run(SKAction.repeatForever(idleLeft), withKey: "dollyIdleLeft")
            break
            
        case "right": let idleRight = SKAction.animate(with: dollyIdleRight, timePerFrame: 0.1)
            player.run(SKAction.repeatForever(idleRight), withKey: "dollyRightIdle")
            break
            
        case "up": let idleUp = SKAction.animate(with: dollyIdleUp, timePerFrame: 0.1)
            player.run(SKAction.repeatForever(idleUp), withKey: "dollyUpIdle")
            break
            
        case "down": let idleDown = SKAction.animate(with: dollyIdleDown, timePerFrame: 0.1)
            player.run(SKAction.repeatForever(idleDown), withKey: "dollyDownIdle")
            break
            
        default:
            break
        }
    }
    
    func dollySpriteAnimation()
    {
        let hitAnimation = SKAction.animate(with: dollyHit,timePerFrame: 0.09)
        dollySprite.run(hitAnimation)
    }
    
    
    
}

//MARK: Bonus
extension GameScene
{
    func AddLife()
    {
        AddHeart()
    }
}

extension GameScene
{
    func CreateHumanBuff()
    {
        let randomPos = Int.random(in: 0...totalArrayTexture.count-2)
        human = SKSpriteNode(imageNamed: "adventurer-idle-2-00")
        human.zPosition = player.zPosition-1
        human.size = player.size
        human.name = "human"
        let humanAnimation = SKAction.animate(with: enemyAnim, timePerFrame: 0.3)
        human.run(SKAction.repeatForever(humanAnimation))
        totalArrayTexture[randomPos].addChild(human)
    }
    
    
}

