//
//  GameScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 13.05.2024.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        let screenCenterPoint = CGPoint(
            x: self.size.width / 2,
            y: self.size.height / 2
        )
        
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIWindow.bounds
        for _ in 1...5 {
            let x: CGFloat = CGFloat(
                GKRandomSource.sharedRandom()
                    .nextInt(upperBound: Int(screen.size.width))
            )
            let y: CGFloat = CGFloat(
                GKRandomSource.sharedRandom()
                    .nextInt(upperBound: Int(screen.size.height))
            )
            
            let flower = Flower.populateFlower(at: CGPoint(x: x, y: y))
            self.addChild(flower)
        }
        
        player = PlayerSnake.populate(at: CGPoint(x: screen.size.width / 2, y: 130))
        self.addChild(player)
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = acceleration.x * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        player.position.x += xAcceleration * 50
        
        if player.position.x < -40 {
            player.position.x = self.size.width + 40
        } else if player.position.x > self.size.width + 40 {
            player.position.x = -40
        }
    }
}
