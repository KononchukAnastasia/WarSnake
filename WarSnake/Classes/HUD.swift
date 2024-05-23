//
//  HUD.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 20.05.2024.
//

import SpriteKit

class HUD: SKNode {
    let scoreBackground = SKSpriteNode(imageNamed: "scores")
    let scoreLabel = SKLabelNode(text: "0")
    var score: Int = 0 {
        didSet {
            scoreLabel.text = score.description
        }
    }
    let menuButton = SKSpriteNode(imageNamed: "menu")
    let life1 = SKSpriteNode(imageNamed: "life")
    let life2 = SKSpriteNode(imageNamed: "life")
    let life3 = SKSpriteNode(imageNamed: "life")
    
    func configureUI(screenSize: CGSize) {
        scoreBackground.xScale = 0.4
        scoreBackground.yScale = 0.3
        scoreBackground.position = CGPoint(
            x: scoreBackground.size.width + 20,
            y: screenSize.height - scoreBackground.size.height / 2 - 60
        )
        scoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        scoreBackground.zPosition = 99
        addChild(scoreBackground)
        
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: -30, y: 1)
        scoreLabel.zPosition = 100
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 70
        scoreBackground.addChild(scoreLabel)
        
        menuButton.xScale = 0.1
        menuButton.yScale = 0.1
        menuButton.position = CGPoint(x: 20, y: 20)
        menuButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        menuButton.zPosition = 100
        menuButton.name = "pause"
        addChild(menuButton)
        
        let lifes = [life1, life2, life3]
        for (index, life) in lifes.enumerated() {
            life.xScale = 0.08
            life.yScale = 0.08
            life.position = CGPoint(
                x: screenSize.width - CGFloat(index + 1) * (life.size.width + 3),
                y: 20
            )
            life.zPosition = 100
            life.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            addChild(life)
        }
    }
}
