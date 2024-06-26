//
//  BitMaskCategory.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 20.05.2024.
//

import SpriteKit

extension SKPhysicsBody {
    var category: BitMaskCategory {
        get {
            return BitMaskCategory(rawValue: self.categoryBitMask)
        }
        
        set {
            self.categoryBitMask = newValue.rawValue
        }
    }
}

struct BitMaskCategory: OptionSet {
    let rawValue: UInt32
    
    static let player = BitMaskCategory(rawValue: 1 << 0)
    static let enemy = BitMaskCategory(rawValue: 1 << 1)
    static let powerUp = BitMaskCategory(rawValue: 1 << 2)
    static let shot = BitMaskCategory(rawValue: 1 << 3)
}
