//
//  PowerUp.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 16.05.2024.
//

import SpriteKit

class PowerUp: SKSpriteNode {

    private let initialSize = CGSize(width: 52, height: 52)
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
        self.name = "Sprite"
        self.zPosition = 20
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.powerUp.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMovement() {
        performRotation()
        
        let moveForward = SKAction.moveTo(y: -100, duration: 5)
        self.run(moveForward)
    }
    
    private func performRotation() {
        for i in 1...6 {
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
