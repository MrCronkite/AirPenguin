//
//  GameScene.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SpriteKit

final class GameScene: SKScene, SKPhysicsContactDelegate {

    private var penguin: Penguin!
    private let level = Level.level1

    override func didMove(to view: SKView) {
        backgroundColor = SKColor(red: 0.7, green: 0.85, blue: 1.0, alpha: 1.0)
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self

        setupPenguin()
        setupGround()
    }

    private func setupPenguin() {
        penguin = Penguin()
        penguin.position = level.startPosition
        addChild(penguin)
    }

    private func setupGround() {
        let ground = SKShapeNode(rectOf: CGSize(width: 2000, height: 40))
        ground.fillColor = .white
        ground.strokeColor = .clear
        ground.position = CGPoint(x: 500, y: 80)

        let body = SKPhysicsBody(rectangleOf: ground.frame.size)
        body.isDynamic = false
        body.categoryBitMask = PhysicsCategory.terrain
        ground.physicsBody = body

        addChild(ground)
    }

    // Обработку жестов подключим следующим шагом

    func didBegin(_ contact: SKPhysicsContact) {
        // Обработку столкновений добавим позже
    }
}
