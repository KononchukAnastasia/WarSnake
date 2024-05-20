//
//  MenuScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 18.05.2024.
//

import SpriteKit

class MenuScene: SKScene {
    override func didMove(to view: SKView) {
        Assets.shared.preloadAssets()
        backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        let texture = SKTexture(imageNamed: "playButton")
        let playButton = SKSpriteNode(texture: texture)
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        playButton.name = "runPlayButton"
        self.addChild(playButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
        if node.name == "runPlayButton" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
    }
}
