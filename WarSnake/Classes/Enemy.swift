//
//  Enemy.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 17.05.2024.
//

import SpriteKit

final class Enemy: SKSpriteNode {

    // MARK: - Static properties
    static var textureAtlas: SKTextureAtlas?
    
    // MARK: - Public properties
    var enemyTexture: SKTexture!
    
    // MARK: Initializers
    init(enemyTexture: SKTexture) {
        let texture = enemyTexture
        super.init(texture: texture, color: .clear, size: CGSize(width: 266, height: 280))
        self.xScale = 0.3
        self.yScale = -0.3
        self.zPosition = 20
        self.name = "Sprite"
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func flySpiral() {
        
        let screenSize = UIWindow.bounds
        
        let timeHorizontal: Double = 3
        let timeVertical: Double = 5
        
        let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizontal)
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        
        let randomNumber = Int(arc4random_uniform(2))
        
        let asideMovementSequence = randomNumber == EnemyDirection.left.rawValue 
        ? SKAction.sequence([moveLeft, moveRight])
        : SKAction.sequence([moveRight, moveLeft])
        
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        
        let forwardMovement = SKAction.moveTo(y: -105, duration: timeVertical)
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        self.run(groupMovement)
    }
}

// MARK: - Enum
enum EnemyDirection: Int {
    case left = 0
    case right
}
