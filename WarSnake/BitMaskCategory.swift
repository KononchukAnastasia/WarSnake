//
//  BitMaskCategory.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 20.05.2024.
//

import Foundation

struct BitMaskCategory {
    static let player : UInt32 = 0x1 << 0
    static let enemy : UInt32 = 0x1 << 1
    static let powerUp : UInt32 = 0x1 << 2
    static let shot : UInt32 = 0x1 << 3
}
