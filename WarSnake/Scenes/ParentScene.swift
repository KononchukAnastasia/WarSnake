//
//  ParentScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 22.05.2024.
//

import SpriteKit

class ParentScene: SKScene {

    // MARK: - Public properties
    let gameSettings = GameSettings()
    let sceneManager = SceneManager.shared
    
    var backScene: SKScene?
    
    // MARK: - Public methods
    func setHeader(withName name: String?, andBackground backgroundName: String) {
        let header = ButtonNode(titled: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        header.yScale = 0.7
        header.xScale = 0.5
        self.addChild(header)
    }
    
    func addImage(named imageName: String, at position: CGPoint) {
        let image = SKSpriteNode(imageNamed: imageName)
        image.position = position
        image.setScale(0.6)
        self.addChild(image)
    }
    
    func addButton(title: String?, name: String, backgroundName: String, at position: CGPoint, xScale: CGFloat, yScale: CGFloat) -> ButtonNode {
        let button = ButtonNode(titled: title, backgroundName: backgroundName)
        button.name = name
        button.position = position
        button.xScale = xScale
        button.yScale = yScale
        addChild(button)
        return button
    }
    
    // MARK: Initializers
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor(red: 0.47, green: 0.65, blue: 0.04, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
