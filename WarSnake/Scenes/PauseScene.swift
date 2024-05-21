//
//  PauseScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 21.05.2024.
//

import SpriteKit

class PauseScene: SKScene {
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor(red: 0.47, green: 0.65, blue: 0.04, alpha: 1.0)
        
        let image = SKSpriteNode(imageNamed: "snake_crawl")
        image.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 228)
        image.setScale(0.6)
        self.addChild(image)
        
        let header = ButtonNode(titled: "pause", backgroundName: "scores")
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        header.setScale(0.7)
        self.addChild(header)
        
        let titles = ["restart", "options", "resume"]
        
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(titled: title, backgroundName: "scores")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
            button.setScale(0.6)
            button.name = title
            button.label.name = title
            addChild(button)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
        if node.name == "restart" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
    }
}
