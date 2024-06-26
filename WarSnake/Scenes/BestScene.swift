//
//  BestScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 22.05.2024.
//

import SpriteKit

final class BestScene: ParentScene {
    
    // MARK: - Public properties
    var places: [Int]!
    
    // MARK: - Override methods
    override func didMove(to view: SKView) {
        
        gameSettings.loadScores()
        places = gameSettings.highScore
        addImage(named: "snake_crawl", at: CGPoint(x: self.frame.midX, y: self.frame.midY + 228))
        setHeader(withName: "best", andBackground: "scores")
        
        let titles = ["back"]
        
        for (index, title) in titles.enumerated() {
            let button = addButton(
                title: title,
                name: title,
                backgroundName: "scores",
                at: CGPoint(
                    x: self.frame.midX,
                    y: self.frame.midY - 200 + CGFloat(100 * index)
                ),
                xScale: 0.4,
                yScale: 0.5)
            button.label.name = title
        }
        
        for (index, value) in places.enumerated() {
            let l = SKLabelNode(text: value.description)
            l.fontColor = UIColor(
                red: 219 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1.0
            )
            l.fontName = "AmericanTypewriter-Bold"
            l.fontSize = 30
            l.position = CGPoint(
                x: self.frame.midX,
                y: self.frame.midY - CGFloat(index * 60)
            )
            addChild(l)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
        if node.name == "back" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
        }
    }
}
