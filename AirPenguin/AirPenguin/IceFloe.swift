//
//  IceFloe.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SpriteKit

final class IceFloe: SKSpriteNode {

    init(size: CGSize) {
        super.init(texture: nil, color: .white, size: size)
        name = "iceFloe"
        zPosition = 1
        setupPhysics()
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
}
