//
//  PhysicsCategory.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import Foundation

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let penguin: UInt32 = 0x1 << 0
    static let terrain: UInt32 = 0x1 << 1
    static let obstacle: UInt32 = 0x1 << 2
    static let finish: UInt32 = 0x1 << 3
    static let fish: UInt32 = 0x1 << 4
}
