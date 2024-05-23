//
//  OptionsScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 22.05.2024.
//

import SpriteKit

class OptionsScene: ParentScene {
    override func didMove(to view: SKView) {
        
        let image = SKSpriteNode(imageNamed: "snake_crawl")
        image.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 228)
        image.setScale(0.6)
        self.addChild(image)
        
        setHeader(withName: "options", andBackground: "scores")
        
        let buttonMusic = ButtonNode(titled: nil, backgroundName: "music")
        buttonMusic.position = CGPoint(x: self.frame.midX - 70, y: self.frame.midY)
        buttonMusic.setScale(0.4)
        buttonMusic.name = "music"
        buttonMusic.label.isHidden = true
        addChild(buttonMusic)
        
        let buttonSound = ButtonNode(titled: nil, backgroundName: "sound")
        buttonSound.position = CGPoint(x: self.frame.midX + 70, y: self.frame.midY)
        buttonSound.setScale(0.4)
        buttonSound.name = "sound"
        buttonSound.label.isHidden = true
        addChild(buttonSound)
        
        let buttonBack = ButtonNode(titled: "back", backgroundName: "scores")
        buttonBack.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        buttonBack.yScale = 0.5
        buttonBack.xScale = 0.4
        buttonBack.name = "back"
        buttonBack.label.name = "back"
        addChild(buttonBack)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
        if node.name == "music" {
            print("music")
            
        } else if node.name == "sound" {
            print("sound")
            
        } else if node.name == "back" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
        }
    }
}
