//
//  Fish.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SpriteKit

final class Fish: SKSpriteNode {

    init() {
        let size = CGSize(width: 24, height: 16)
        super.init(texture: nil, color: .orange, size: size)
        name = "fish"
        zPosition = 5 // между льдиной и пингвином
        setupPhysics()
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
}
