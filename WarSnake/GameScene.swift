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
        
        enumerateChildNodes(withName: "backgroundSprite") { node, stop in
            if node.position.y < -100 {
                node.removeFromParent()
            }
        }
    }
}
