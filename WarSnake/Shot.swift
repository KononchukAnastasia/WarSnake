//
//  Shot.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 18.05.2024.
//

import SpriteKit

class Shot: SKSpriteNode {

    let screenSize = UIWindow.bounds
    
    private let initialSize = CGSize(width: 187, height: 237)
    private let textureAtlas: SKTextureAtlas!
    private var textureNameBeginWith = ""
    private var animationSpriteArray = [SKTexture]()
    
    init(textureAtlas: SKTextureAtlas) {
        self.textureAtlas = textureAtlas
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        textureNameBeginWith = String(textureName.dropLast(5))
        super.init(texture: texture, color: .clear, size: initialSize)
        self.setScale(0.35)
        self.name = "ShotSprite"
        self.zPosition = 30
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = BitMaskCategory.shot
        self.physicsBody?.collisionBitMask = BitMaskCategory.enemy
        self.physicsBody?.contactTestBitMask = BitMaskCategory.enemy
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMovement() {
        performRotation()
        
        let moveForward = SKAction.moveTo(y: screenSize.height + 100, duration: 2)
        self.run(moveForward)
    }
    
    private func performRotation() {
        for i in 1...32 {
            let number = String(format: "%d", i)
            animationSpriteArray.append(SKTexture(imageNamed: textureNameBeginWith + number.description))
        }
        
        SKTexture.preload(animationSpriteArray) {
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
    }
}