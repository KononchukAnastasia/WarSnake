//
//  YellowShot.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 18.05.2024.
//

import SpriteKit

final class YellowShot: Shot {

    // MARK: Initializers
    init() {
        let textureAtlas = Assets.shared.yellowShotAtlas
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
