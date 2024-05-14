//
//  Bush.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 13.05.2024.
//

import SpriteKit
import GameplayKit

final class Flower: SKSpriteNode {
    
    static func populateFlower(at point: CGPoint?) -> Flower {
        let flowerImageName = configureFlowerName()
        let flower = Flower(imageNamed: flowerImageName)
        flower.setScale(randomScaleFactor)
        flower.position = point ?? randomPoint()
        flower.zPosition = 1
        flower.name = "backgroundSprite"
        flower.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        flower.run(rotateForRandomAngle())
        flower.run(move(from: flower.position))
        return flower
    }
    
    fileprivate static func randomPoint() -> CGPoint {
        let screen = UIWindow.bounds
        let distribution =  GKRandomDistribution(lowestValue: Int(screen.size.height) + 100, highestValue: Int(screen.size.height) + 200)
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x, y: y)
    }
    
    fileprivate static func configureFlowerName() -> String {
        let distribution =  GKRandomDistribution(lowestValue: 1, highestValue: 9)
        let randomNumber = distribution.nextInt()
        let imageName = "flower" + "\(randomNumber)"
        return imageName
    }
    
    fileprivate static var randomScaleFactor: CGFloat {
        let distribution =  GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 100
        return randomNumber
    }
    
    fileprivate static func rotateForRandomAngle() -> SKAction {
        let distribution =  GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        
        let movePoint = CGPoint(x: point.x, y: point.y - UIWindow.bounds.height - 400)
        let moveDistance = point.y + UIWindow.bounds.height + 400
        let movementSpeed: CGFloat = 100.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: duration)
    }
    
}
