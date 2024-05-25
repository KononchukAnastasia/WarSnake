//
//  GameSettings.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 24.05.2024.
//

import UIKit

final class GameSettings: NSObject {

    // MARK: - Public properties
    let ud = UserDefaults.standard
    
    var isMusic = true
    var isSound = true
    
    let musicKey = "music"
    let soundKey = "sound"
    
    let highScoreKey = "highScore"
    var highScore: [Int] = []
    var currentScore = 0

    // MARK: Initializers
    override init() {
        super.init()
        
        loadGameSettings()
        loadScores()
    }
    
    // MARK: - Public methods
    func saveScores() {
        highScore.append(currentScore)
        highScore = Array(highScore.sorted { $0 > $1}.prefix(3))
        
        ud.set(highScore, forKey: highScoreKey)
        ud.synchronize()
    }
    
    func loadScores() {
        guard ud.value(forKey: highScoreKey) != nil else { return }
        highScore = ud.array(forKey: highScoreKey) as! [Int]
    }
    
    func saveGameSettings() {
        ud.set(isMusic, forKey: musicKey)
        ud.set(isSound, forKey: soundKey)
    }
    
    func loadGameSettings() {
        guard ud.value(forKey: musicKey) != nil
                && ud.value(forKey: soundKey) != nil
        else { return }
        isMusic = ud.bool(forKey: musicKey)
        isSound = ud.bool(forKey: soundKey)
    }
}
