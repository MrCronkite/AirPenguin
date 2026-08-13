//
//  Level.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import CoreGraphics

struct IceFloeData {
    let position: CGPoint
    let size: CGSize
}

struct Level {
    let startPosition: CGPoint
    let finishPosition: CGPoint
    let iceFloes: [IceFloeData]
    let fishPositions: [CGPoint]

    static let level1 = Level(
        startPosition: CGPoint(x: 200, y: 150),
        finishPosition: CGPoint(x: 220, y: 4000),

        iceFloes: [
            // START
            IceFloeData(
                position: CGPoint(x: 200, y: 150),
                size: CGSize(width: 260, height: 200)
            ),

            IceFloeData(
                position: CGPoint(x: 220, y: 450),
                size: CGSize(width: 260, height: 200)
            ),

            IceFloeData(
                position: CGPoint(x: 160, y: 750),
                size: CGSize(width: 240, height: 200)
            ),

            IceFloeData(
                position: CGPoint(x: 250, y: 1050),
                size: CGSize(width: 260, height: 200)
            ),

            IceFloeData(
                position: CGPoint(x: 180, y: 1350),
                size: CGSize(width: 230, height: 200)
            ),

            IceFloeData(
                position: CGPoint(x: 280, y: 1650),
                size: CGSize(width: 260, height: 200)
            ),

            IceFloeData(
                position: CGPoint(x: 200, y: 1950),
                size: CGSize(width: 240, height: 200)
            ),

            IceFloeData(
                position: CGPoint(x: 120, y: 2250),
                size: CGSize(width: 220, height: 200)
            ),

            IceFloeData(
                position: CGPoint(x: 220, y: 2550),
                size: CGSize(width: 260, height: 200)
            ),

            IceFloeData(
                position: CGPoint(x: 300, y: 2850),
                size: CGSize(width: 220, height: 200)
            ),

            IceFloeData(
                position: CGPoint(x: 180, y: 3150),
                size: CGSize(width: 240, height: 200)
            ),

            IceFloeData(
                position: CGPoint(x: 100, y: 3450),
                size: CGSize(width: 220, height: 200)
            ),

            // FINISH
            IceFloeData(
                position: CGPoint(x: 220, y: 4000),
                size: CGSize(width: 300, height: 250)
            )
        ],

        fishPositions: [
            CGPoint(x: 200, y: 150),
            CGPoint(x: 260, y: 420),
            CGPoint(x: 140, y: 720),
            CGPoint(x: 250, y: 1020),
            CGPoint(x: 180, y: 1320),
            CGPoint(x: 280, y: 1620),
            CGPoint(x: 200, y: 1920),
            CGPoint(x: 120, y: 2220),
            CGPoint(x: 220, y: 2520),
            CGPoint(x: 300, y: 2820),
            CGPoint(x: 180, y: 3120),
            CGPoint(x: 100, y: 3420),
            CGPoint(x: 220, y: 3970)
        ]
    )
}
