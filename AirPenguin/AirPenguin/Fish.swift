//
//  Fish.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SpriteKit

import SpriteKit

final class Fish: SKSpriteNode {

    init() {
        let firstTexture = SKTexture(imageNamed: "fish_01")
        let size = CGSize(width: 32, height: 32)
        super.init(texture: firstTexture, color: .clear, size: size)
        name = "fish"
        zPosition = 5
        setupPhysics()
        startSwimAnimation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPhysics() {
        let body = SKPhysicsBody(rectangleOf: size)
        body.isDynamic = false
        body.categoryBitMask = PhysicsCategory.fish
        body.collisionBitMask = PhysicsCategory.none
        body.contactTestBitMask = PhysicsCategory.penguin
        physicsBody = body
    }

    private func startSwimAnimation() {
        let textures = (1...20).map { SKTexture(imageNamed: String(format: "fish_%02d", $0)) }

        let animate = SKAction.animate(with: textures, timePerFrame: 0.06, resize: false, restore: false)
        let loop = SKAction.repeatForever(animate)

        // Небольшая случайная задержка старта, чтобы рыбки не двигались синхронно
        let randomDelay = Double.random(in: 0...1.0)
        run(SKAction.sequence([SKAction.wait(forDuration: randomDelay), loop]))
    }
}
