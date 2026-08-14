//
//  LevelGenerator.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SpriteKit

final class LevelGenerator {

    // MARK: - Настройки

    private let floeWidthRange: ClosedRange<CGFloat> = 250...300   // было 320...420
    private let floeHeightRange: ClosedRange<CGFloat> = 250...300   // было 260...320

    // Расстояние между центрами льдин по Y — немного сократили под прыжок
    private let verticalGapRange: ClosedRange<CGFloat> = 300...380 // было 320...420

    private let horizontalOffset: CGFloat = 120
    private let minX: CGFloat = 150
    private let maxX: CGFloat = 450

    private let fishCountRange: ClosedRange<Int> = 0...2
    private let fishMargin: CGFloat = 30

    // MARK: - State

    private(set) var iceFloes: [IceFloeData] = []
    private(set) var fishPositions: [CGPoint] = []

    private var currentX: CGFloat = 300
    private var currentY: CGFloat = 200

    // MARK: - Init

    init() {
        let startFloe = IceFloeData(
            position: CGPoint(x: currentX, y: currentY),
            size: CGSize(width: 250, height: 250)
        )
        iceFloes.append(startFloe)
        generateFish(on: startFloe)
        generateNextFloes(count: 10)
    }

    // MARK: - Public

    // Y последней сгенерированной льдины — по нему GameScene поймёт, когда пора генерировать ещё
    var lastFloeY: CGFloat { currentY }

    func generateNextFloes(count: Int = 10) {
        for _ in 0..<count {
            generateNextFloe()
        }
    }

    // MARK: - Private

    private func generateNextFloe() {
        currentY += CGFloat.random(in: verticalGapRange)

        let offset = CGFloat.random(in: -horizontalOffset...horizontalOffset)
        currentX = max(minX, min(maxX, currentX + offset))

        let size = CGSize(
            width: CGFloat.random(in: floeWidthRange),
            height: CGFloat.random(in: floeHeightRange)
        )

        let floe = IceFloeData(position: CGPoint(x: currentX, y: currentY), size: size)

        iceFloes.append(floe)
        generateFish(on: floe)
    }

    // MARK: - Fish

    private func generateFish(on floe: IceFloeData) {
        let count = Int.random(in: fishCountRange)
        guard count > 0 else { return }

        let xRange = (floe.position.x - floe.size.width / 2 + fishMargin)...(floe.position.x + floe.size.width / 2 - fishMargin)
        let yRange = (floe.position.y - floe.size.height / 2 + fishMargin)...(floe.position.y + floe.size.height / 2 - fishMargin)

        for _ in 0..<count {
            let point = CGPoint(x: CGFloat.random(in: xRange), y: CGFloat.random(in: yRange))
            fishPositions.append(point)
        }
    }
}
