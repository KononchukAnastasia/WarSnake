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
    
    override func didMove(to view: SKView) {
        configureStartScene()
        spawnFlower()
        player.performСrawl()
        spawnPowerUp()
//        spawnEnemy(count: 5)
        spawnEnemies()
    }
    
    private func spawnEnemies() {
        let waitAction = SKAction.wait(forDuration: 3.0)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, spawnSpiralAction])))
    }
    
    private func spawnSpiralOfEnemies() {
           let enemyTextureAtlas1 = SKTextureAtlas(named: "Enemy1")
           let enemyTextureAtlas2 = SKTextureAtlas(named: "Enemy2")
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
    }
}
