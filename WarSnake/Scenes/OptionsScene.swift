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
        addImage(named: "snake_crawl", at: CGPoint(x: self.frame.midX, y: self.frame.midY + 228))
        setHeader(withName: "options", andBackground: "scores")
        
        let backgroundNameForMusic = isMusic == true ? "music" : "nomusic"
        let buttonMusic = addButton(
            title: nil,
            name: "music",
            backgroundName: backgroundNameForMusic,
            at: CGPoint(x: self.frame.midX - 70, y: self.frame.midY),
            xScale: 0.4,
            yScale: 0.4
        )
        buttonMusic.label.isHidden = true
        
        let backgroundNameForSound = isSound == true ? "sound" : "nosound"
        let buttonSound = addButton(
            title: nil,
            name: "sound",
            backgroundName: backgroundNameForSound,
            at: CGPoint(x: self.frame.midX + 70, y: self.frame.midY),
            xScale: 0.4,
            yScale: 0.4
        )
        buttonSound.label.isHidden = true
        
        let buttonBack = addButton(
            title: "back",
            name: "back",
            backgroundName: "scores",
            at: CGPoint(x: self.frame.midX, y: self.frame.midY - 100),
            xScale: 0.4,
            yScale: 0.5
        )
        buttonBack.label.name = "back"
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
            node.texture = property 
            ? SKTexture(imageNamed: name)
            : SKTexture(imageNamed: "no" + name)
        }
    }
}
