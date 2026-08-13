//
//  LevelGenerator.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SpriteKit

final class LevelGenerator {

    // MARK: - Настройки

    private let floeWidthRange: ClosedRange<CGFloat> = 220...280
    private let floeHeightRange: ClosedRange<CGFloat> = 180...220

    // Расстояние между центрами льдин по Y
    private let verticalGapRange: ClosedRange<CGFloat> = 180...260

    // Максимальное смещение следующей льдины по X
    private let horizontalOffset: CGFloat = 100

    // Границы игрового поля
    private let minX: CGFloat = 100
    private let maxX: CGFloat = 300

    // Рыба
    private let fishCountRange: ClosedRange<Int> = 0...2

    // MARK: - State

    private(set) var iceFloes: [IceFloeData] = []
    private(set) var fishPositions: [CGPoint] = []

    private var currentY: CGFloat = 150
    private var currentX: CGFloat = 200

    // MARK: - Init

    init() {
        generateInitialFloes()
    }

    // MARK: - Public

    func generateNextFloes(count: Int = 10) {

        for _ in 0..<count {
            generateNextFloe()
        }
    }

    // MARK: - Private

    private func generateInitialFloes() {

        let startFloe = IceFloeData(
            position: CGPoint(x: currentX, y: currentY),
            size: CGSize(width: 260, height: 200)
        )

        iceFloes.append(startFloe)

        generateFish(on: startFloe)

        generateNextFloes(count: 10)
    }

    private func generateNextFloe() {

        // Случайное расстояние по Y
        let verticalGap = CGFloat.random(
            in: verticalGapRange
        )

        currentY += verticalGap

        // Случайное движение по X
        let randomOffset = CGFloat.random(
            in: -horizontalOffset...horizontalOffset
        )

        currentX += randomOffset

        // Не даём льдине выйти за границы
        currentX = max(
            minX,
            min(maxX, currentX)
        )

        let width = CGFloat.random(
            in: floeWidthRange
        )

        let height = CGFloat.random(
            in: floeHeightRange
        )

        let floe = IceFloeData(
            position: CGPoint(
                x: currentX,
                y: currentY
            ),
            size: CGSize(
                width: width,
                height: height
            )
        )

        iceFloes.append(floe)

        generateFish(on: floe)
    }

    // MARK: - Fish

    private func generateFish(on floe: IceFloeData) {

        let count = Int.random(
            in: fishCountRange
        )

        guard count > 0 else {
            return
        }

        for _ in 0..<count {

            let margin: CGFloat = 30

            let x = CGFloat.random(
                in: (floe.position.x - floe.size.width / 2 + margin)
                ...
                (floe.position.x + floe.size.width / 2 - margin)
            )

            let y = CGFloat.random(
                in: (floe.position.y - floe.size.height / 2 + margin)
                ...
                (floe.position.y + floe.size.height / 2 - margin)
            )

            fishPositions.append(
                CGPoint(x: x, y: y)
            )
        }
    }
}
