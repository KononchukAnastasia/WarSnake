//
//  GameScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 13.05.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
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
    }
}
