//
//  GameOverScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 22.05.2024.
//

import SpriteKit

class GameOverScene: ParentScene {
    
    override func didMove(to view: SKView) {
        
        let image = SKSpriteNode(imageNamed: "snake_crawl")
        image.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 228)
        image.setScale(0.6)
        self.addChild(image)
        
        setHeader(withName: "game over", andBackground: "scores")
        
        let titles = ["restart", "options", "best"]
        
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
            sceneManager.gameScene = nil
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
            
        } else if node.name == "options" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let optionScene = OptionsScene(size: self.size)
            optionScene.backScene = self
            optionScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionScene, transition: transition)
            
        } else if node.name == "best" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(bestScene, transition: transition)
        }
    }
}