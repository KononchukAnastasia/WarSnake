//
//  PlayerSnake.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 14.05.2024.
//

import SpriteKit
import CoreMotion

class PlayerSnake: SKSpriteNode {
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIWindow.bounds.width, height: UIWindow.bounds.height)
    
    static func populate(at point: CGPoint) -> PlayerSnake {
        let playerSnakeTexture = SKTexture(imageNamed: "snake4")
        let playerSnake = PlayerSnake(texture: playerSnakeTexture)
        playerSnake.setScale(0.5)
        playerSnake.position = point
        playerSnake.zPosition = 20
        return playerSnake
    }
    
    func checkPozition() {
        self.position.x += xAcceleration * 50
        
        if self.position.x < -40 {
            self.position.x = screenSize.width + 40
        } else if self.position.x > screenSize.width + 40 {
            self.position.x = -40
        }
    }
    
    func performСrawl() {
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = acceleration.x * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
}
