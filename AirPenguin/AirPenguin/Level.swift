//
//  Level.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import CoreGraphics

struct Level {
    let startPosition: CGPoint
    let finishPosition: CGPoint
    // Позже сюда добавим точки рельефа и препятствия

    static let level1 = Level(
        startPosition: CGPoint(x: 100, y: 500),
        finishPosition: CGPoint(x: 900, y: 100)
    )
}
