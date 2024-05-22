//
//  BluePowerUp.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 16.05.2024.
//

import SpriteKit

class BluePowerUp: PowerUp {
    
    init() {
        let textureAtlas = Assets.shared.bluePowerUpAtlas
        super.init(textureAtlas: textureAtlas)
        name = "BluePowerUp"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
