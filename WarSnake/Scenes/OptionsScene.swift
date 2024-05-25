//
//  OptionsScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 22.05.2024.
//

import SpriteKit

final class OptionsScene: ParentScene {
    
    // MARK: - Public properties
    var isMusic: Bool!
    var isSound: Bool!
    
    // MARK: - Override methods
    override func didMove(to view: SKView) {
        
        isMusic = gameSettings.isMusic
        isSound = gameSettings.isSound
        
        let image = SKSpriteNode(imageNamed: "snake_crawl")
        image.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 228)
        image.setScale(0.6)
        self.addChild(image)
        
        setHeader(withName: "options", andBackground: "scores")
        
        let backgroundNameForMusic = isMusic == true ? "music" : "nomusic"
        
        let buttonMusic = ButtonNode(titled: nil, backgroundName: backgroundNameForMusic)
        buttonMusic.position = CGPoint(x: self.frame.midX - 70, y: self.frame.midY)
        buttonMusic.setScale(0.4)
        buttonMusic.name = "music"
        buttonMusic.label.isHidden = true
        addChild(buttonMusic)
        
        let backgroundNameForSound = isSound == true ? "sound" : "nosound"
        
        let buttonSound = ButtonNode(titled: nil, backgroundName: backgroundNameForSound)
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
        print("Touched node: \(node.name ?? "unknown")")
        
        if node.name == "music" {
            isMusic = !isMusic
            update(node: node as! SKSpriteNode, property: isMusic)
            
        } else if node.name == "sound" {
            isSound = !isSound
            update(node: node as! SKSpriteNode, property: isSound)
            
        } else if node.name == "back" {
            
            gameSettings.isMusic = isMusic
            gameSettings.isSound = isSound
            gameSettings.saveGameSettings()
            
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
        }
    }
    
    func update(node: SKSpriteNode, property: Bool) {
        if let name = node.name {
            node.texture = property ? SKTexture(imageNamed: name) : SKTexture(imageNamed: "no" + name)
        }
    }
}
