//
//  PlayerSnake.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 14.05.2024.
//

import SpriteKit
import CoreMotion

final class PlayerSnake: SKSpriteNode {
    
    // MARK: - Private properties
    private let motionManager = CMMotionManager()
    private var xAcceleration: CGFloat = 0
    private let screenSize = CGSize(
        width: UIWindow.bounds.width,
        height: UIWindow.bounds.height
    )
    private var moveTextureArrayAnimation = [SKTexture]()
    
    // MARK: - Public static methods
    static func populate(at point: CGPoint) -> PlayerSnake {
        let atlas = Assets.shared.playerSnakeAtlas
        let playerSnakeTexture = atlas.textureNamed("snake4")
        let playerSnake = PlayerSnake(texture: playerSnakeTexture)
        playerSnake.setScale(0.3)
        playerSnake.position = point
        playerSnake.zPosition = 40

        playerSnake.physicsBody = SKPhysicsBody(
            texture: playerSnakeTexture,
            alphaThreshold: 0.5,
            size: playerSnake.size
        )
        playerSnake.physicsBody?.isDynamic = false
        playerSnake.physicsBody?.categoryBitMask = BitMaskCategory.player.rawValue
        playerSnake.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue 
        | BitMaskCategory.powerUp.rawValue
        playerSnake.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue 
        | BitMaskCategory.powerUp.rawValue
        
        return playerSnake
    }
    
    // MARK: - Public methods
    func checkPozition() {
        self.position.x += xAcceleration * 50
        
        if self.position.x < -20 {
            self.position.x = screenSize.width + 20
        } else if self.position.x > screenSize.width + 20 {
            self.position.x = -20
        }
    }
    
    func performСrawl() {
        playingAnimationFillArray {
            let snakeAnimationAction = SKAction.animate(
                with: self.moveTextureArrayAnimation,
                timePerFrame: 0.15,
                resize: true,
                restore: false
            )
            
            let snakeAnimationForever = SKAction.repeatForever(snakeAnimationAction)
            self.run(snakeAnimationForever)
        }
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { 
            [unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = acceleration.x * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
    
    func yellowPowerUp() {
        let colorAction = SKAction.colorize(
            with: .orange,
            colorBlendFactor: 1.0,
            duration: 0.2
        )
        let uncolorAction = SKAction.colorize(
            with: .orange,
            colorBlendFactor: 0.0,
            duration: 0.2
        )
        let sequenceAction = SKAction.sequence([colorAction, uncolorAction])
        let repeatAction = SKAction.repeat(sequenceAction, count: 5)
        self.run(repeatAction)
    }
    
    func bluePowerUp() {
        let colorAction = SKAction.colorize(
            with: .systemCyan,
            colorBlendFactor: 1.0,
            duration: 0.2
        )
        
        let uncolorAction = SKAction.colorize(
            with: .systemCyan,
            colorBlendFactor: 0.0,
            duration: 0.2
        )
        
        let sequenceAction = SKAction.sequence([colorAction, uncolorAction])
        let repeatAction = SKAction.repeat(sequenceAction, count: 5)
        self.run(repeatAction)
    }
    
    // MARK: - Private methods
    private func playingAnimationFillArray(completion: @escaping () -> Void) {
        SKTextureAtlas.preloadTextureAtlases(
            [SKTextureAtlas(named: "playerSnake")]) { [unowned self] in
            self.moveTextureArrayAnimation = {
                var array = [SKTexture]()
                for i in stride(from: 1, through: 8, by: 1) {
                    let number = String(format: "%d", i)
                    let texture = SKTexture(imageNamed: "snake\(number)")
                    array.append(texture)
                }
                
                SKTexture.preload(array) {
                    print("preload is done")
                    completion()
                }
                return array
            }()
        }
    }
}
