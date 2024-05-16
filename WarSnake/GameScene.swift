//
//  GameScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 13.05.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: PlayerSnake!
    
    override func didMove(to view: SKView) {
        configureStartScene()
        spawnFlower()
        player.performСrawl()
        spawnPowerUp()
    }
    
    fileprivate func spawnPowerUp() {
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
    
    fileprivate func spawnFlower() {
        let spawnFlowerWait = SKAction.wait(forDuration: 1)
        let spawnFlowerAction = SKAction.run {
            let flower = Flower.populateFlower(at: nil)
            self.addChild(flower)
        }
        
        let spawnFlowerSequence = SKAction.sequence([spawnFlowerWait, spawnFlowerAction])
        let spawnFlowerForever = SKAction.repeatForever(spawnFlowerSequence)
        run(spawnFlowerForever)
    }
    
    fileprivate func configureStartScene() {
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
        
        
        player = PlayerSnake.populate(at: CGPoint(x: screen.size.width / 2, y: 130))
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
