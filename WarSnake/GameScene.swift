//
//  GameScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 13.05.2024.
//

import SpriteKit
import GameplayKit

final class GameScene: SKScene {
    
    var player: PlayerSnake!
    
    let scoreBackground = SKSpriteNode(imageNamed: "scores")
    let scoreLabel = SKLabelNode(text: "1000")
    let menuButton = SKSpriteNode(imageNamed: "menu")
    let life1 = SKSpriteNode(imageNamed: "life")
    let life2 = SKSpriteNode(imageNamed: "life")
    let life3 = SKSpriteNode(imageNamed: "life")
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene()
        spawnFlower()
        player.performСrawl()
        spawnPowerUp()
        spawnEnemies()
        configureUI()
    }
    
    private func configureUI() {
        scoreBackground.xScale = 0.4
        scoreBackground.yScale = 0.3
        scoreBackground.position = CGPoint(
            x: scoreBackground.size.width + 10,
            y: self.size.height - scoreBackground.size.height / 2 - 10
        )
        scoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        scoreBackground.zPosition = 99
        addChild(scoreBackground)
        
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: -30, y: 1)
        scoreLabel.zPosition = 100
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 70
        scoreBackground.addChild(scoreLabel)
        
        menuButton.xScale = 0.1
        menuButton.yScale = 0.1
        menuButton.position = CGPoint(x: 20, y: 20)
        menuButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        menuButton.zPosition = 100
        addChild(menuButton)
        
        let lifes = [life1, life2, life3]
        for (index, life) in lifes.enumerated() {
            life.xScale = 0.08
            life.yScale = 0.08
            life.position = CGPoint(x: self.size.width - CGFloat(index + 1) * (life.size.width + 3), y: 20)
            life.zPosition = 100
            life.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            addChild(life)
        }
        
        
    }
    
    private func spawnEnemies() {
        let waitAction = SKAction.wait(forDuration: 3.0)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, spawnSpiralAction])))
    }
    
    private func spawnSpiralOfEnemies() {
        let enemyTextureAtlas1 = Assets.shared.enemy1Atlas
        let enemyTextureAtlas2 = Assets.shared.enemy2Atlas
           SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
                
               let randomNumber = Int(arc4random_uniform(2))
               let arrayOfAtlases = [enemyTextureAtlas1, enemyTextureAtlas2]
               let textureAtlas = arrayOfAtlases[randomNumber]
               
               let waitAction = SKAction.wait(forDuration: 1.0)
               let spawnEnemy = SKAction.run { [unowned self] in
                   let textureNames = textureAtlas.textureNames.sorted()
                   let texture = textureAtlas.textureNamed(textureNames[0])
                   let enemy = Enemy(enemyTexture: texture)
                   enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 110)
                   self.addChild(enemy)
                   enemy.flySpiral()
               }
               
               let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
               let repeatAction = SKAction.repeat(spawnAction, count: 3)
               
               self.run(repeatAction)
           }
       }
    
    private func spawnPowerUp() {
        let spawnAction = SKAction.run {
            let randomNumber = Int(arc4random_uniform(2))
            let powerUp = randomNumber == 1 ? BluePowerUp() : YellowPowerUp()
            let randomPositionX = arc4random_uniform(UInt32(self.size.width))
            
            powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
            powerUp.startMovement()
            self.addChild(powerUp)
        }
        
        let randomTimeSpawn = Double(arc4random_uniform(11) + 10)
        let waitAction = SKAction.wait(forDuration: randomTimeSpawn)
        
        self.run(SKAction.repeatForever(SKAction.sequence([spawnAction, waitAction])))
    }
    
    private func spawnFlower() {
        let spawnFlowerWait = SKAction.wait(forDuration: 1)
        let spawnFlowerAction = SKAction.run {
            let flower = Flower.populateFlower(at: nil)
            self.addChild(flower)
        }
        
        let spawnFlowerSequence = SKAction.sequence([spawnFlowerWait, spawnFlowerAction])
        let spawnFlowerForever = SKAction.repeatForever(spawnFlowerSequence)
        run(spawnFlowerForever)
    }
    
    private func configureStartScene() {
        let screenCenterPoint = CGPoint(
            x: self.size.width / 2,
            y: self.size.height / 2
        )
        
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIWindow.bounds
            
        let flower1 = Flower.populateFlower(at: CGPoint(x: 100, y: 200))
        self.addChild(flower1)
        
        let flower2 = Flower.populateFlower(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
        self.addChild(flower2)
        
        
        player = PlayerSnake.populate(at: CGPoint(x: screen.size.width / 2, y: 90))
        self.addChild(player)
    }
    
    override func didSimulatePhysics() {
        
        player.checkPozition()
        
        enumerateChildNodes(withName: "Sprite") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "ShotSprite") { (node, stop) in
            if node.position.y >= self.size.height + 100 {
                node.removeFromParent()
            }
        }
    }
    
    private func playerFire() {
        let shot = YellowShot()
        shot.position = CGPoint(x: self.player.position.x, y: self.player.position.y + 40)
        shot.startMovement()
        self.addChild(shot)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerFire()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        
        switch contactCategory {
        case [.enemy, .player]: print("enemy vc player")
        case [.powerUp, .player]: print("powerUp vc player")
        case [.enemy, .shot]: print("enemy vc shot")
        default: preconditionFailure("Unable to detect collision category")
            
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("print")
    }
}
