//
//  IceFloe.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SpriteKit

final class IceFloe: SKSpriteNode {

    init(size: CGSize) {
        let firstTexture = SKTexture(imageNamed: "ice30_01")
        super.init(texture: firstTexture, color: .clear, size: size)
        name = "iceFloe"
        zPosition = 1
        setupPhysics()
        startIdleAnimation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPhysics() {
        let body = SKPhysicsBody(rectangleOf: size)
        body.isDynamic = false
        body.categoryBitMask = PhysicsCategory.terrain
        body.collisionBitMask = PhysicsCategory.penguin
        body.contactTestBitMask = PhysicsCategory.penguin
        physicsBody = body
    }

    private func startIdleAnimation() {
        let textures = (1...20).map { SKTexture(imageNamed: String(format: "ice30_%02d", $0)) }

        let animate = SKAction.animate(with: textures, timePerFrame: 0.12, resize: false, restore: false)
        let loop = SKAction.repeatForever(animate)

        let randomDelay = Double.random(in: 0...1.0)
        run(SKAction.sequence([SKAction.wait(forDuration: randomDelay), loop]))
    }
}
