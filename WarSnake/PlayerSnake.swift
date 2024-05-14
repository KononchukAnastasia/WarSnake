//
//  PlayerSnake.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 14.05.2024.
//

import SpriteKit

class PlayerSnake: SKSpriteNode {
    static func populate(at point: CGPoint) -> SKSpriteNode {
        let playerSnakeTexture = SKTexture(imageNamed: "snake4")
        let playerSnake = SKSpriteNode(texture: playerSnakeTexture)
        playerSnake.setScale(0.5)
        playerSnake.position = point
        playerSnake.zPosition = 20
        
        return playerSnake
    }
}
