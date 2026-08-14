//
//  WaterBackground.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 14.08.2026.
//

import SpriteKit

final class WaterBackground: SKNode {

    private var tiles: [SKSpriteNode] = []
    private let scrollSpeed: CGFloat = 40 // скорость течения, пикселей/сек
    private var tileHeight: CGFloat = 0

    init(screenSize: CGSize) {
        super.init()
        setupTiles(screenSize: screenSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTiles(screenSize: CGSize) {
        let texture = SKTexture(imageNamed: "water_waves")

        // Берём тайл чуть выше экрана, чтобы гарантированно перекрывать края при скролле
        let tileSize = CGSize(width: screenSize.width * 1.2, height: screenSize.height * 1.2)
        tileHeight = tileSize.height

        for i in 0..<2 {
            let tile = SKSpriteNode(texture: texture, size: tileSize)
            tile.zPosition = -10
            tile.position = CGPoint(x: 0, y: CGFloat(i) * tileHeight)
            addChild(tile)
            tiles.append(tile)
        }
    }

    // Вызываем каждый кадр из GameScene.update
    func update(deltaTime: TimeInterval) {
        let offset = scrollSpeed * CGFloat(deltaTime)

        for tile in tiles {
            tile.position.y -= offset

            // Как только тайл полностью ушёл вниз за пределы второго тайла — переносим его наверх
            if tile.position.y <= -tileHeight {
                tile.position.y += tileHeight * CGFloat(tiles.count)
            }
        }
    }
}
