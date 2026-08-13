//
//  Penguin.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SpriteKit

final class Penguin: SKSpriteNode {

    init() {
        let size = CGSize(width: 40, height: 50)
        super.init(texture: nil, color: .black, size: size)
        name = "penguin"
        setupPhysics()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPhysics() {
        let body = SKPhysicsBody(rectangleOf: size)
        body.affectedByGravity = true
        body.allowsRotation = false
        body.friction = 0.2
        body.restitution = 0.1
        body.categoryBitMask = PhysicsCategory.penguin
        body.collisionBitMask = PhysicsCategory.terrain | PhysicsCategory.obstacle
        body.contactTestBitMask = PhysicsCategory.terrain | PhysicsCategory.obstacle | PhysicsCategory.finish
        physicsBody = body
    }
}
