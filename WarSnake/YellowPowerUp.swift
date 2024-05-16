//
//  YellowPowerUp.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 16.05.2024.
//

import SpriteKit

class YellowPowerUp: PowerUp {
    
    init() {
        let textureAtlas = SKTextureAtlas(named: "YellowPowerUp")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
