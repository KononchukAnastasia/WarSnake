//
//  Assets.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 18.05.2024.
//

import SpriteKit

final class Assets {
    
    // MARK: Shared Instance
    static let shared = Assets()
    
    // MARK: - Public properties
    var isLoaded = false
    
    let yellowShotAtlas = SKTextureAtlas(named: "YellowShot")
    let enemy1Atlas = SKTextureAtlas(named: "Enemy1")
    let enemy2Atlas = SKTextureAtlas(named: "Enemy2")
    let yellowPowerUpAtlas = SKTextureAtlas(named: "YellowPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let playerSnakeAtlas = SKTextureAtlas(named: "playerSnake")
    
    // MARK: - Public methods
    func preloadAssets() {
        yellowShotAtlas.preload { print("yellowShotAtlas preloaded")}
        enemy1Atlas.preload { print("enemy1Atlas preloaded")}
        enemy2Atlas.preload { print("enemy2Atlas preloaded")}
        yellowPowerUpAtlas.preload { print("yellowPowerUpAtlas preloaded")}
        bluePowerUpAtlas.preload { print("bluePowerUpAtlas preloaded")}
        playerSnakeAtlas.preload { print("playerSnakeAtlas preloaded")}
    }
}
