//
//  Penguin.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SpriteKit


final class Penguin: SKSpriteNode {

    // MARK: - Движение

    private let forwardSpeed: CGFloat = 120
    private let jumpBoostSpeed: CGFloat = 350
    private let jumpDuration: TimeInterval = 0.7
    private let horizontalSpeed: CGFloat = 300

    private(set) var isJumping = false

    // MARK: - Init

    init() {
        let size = CGSize(width: 55, height: 62)
        super.init(texture: nil, color: .clear, size: size)
        name = "penguin"
        zPosition = 10
        zRotation = .pi

        // Ставим первый кадр как текстуру по умолчанию
        if let first = loadRunFrames.first {
            texture = first
        }

        setupPhysics()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var loadRunFrames: [SKTexture] {
        return (1...6).map { index in
            SKTexture(imageNamed: "penguin_run_0\(index)")
        }
    }

    // MARK: - Физика

    private func setupPhysics() {
        let body = SKPhysicsBody(rectangleOf: size)
        body.affectedByGravity = false
        body.allowsRotation = false
        body.friction = 0
        body.linearDamping = 0
        body.categoryBitMask = PhysicsCategory.penguin
        body.collisionBitMask = PhysicsCategory.none
        body.contactTestBitMask = PhysicsCategory.finish | PhysicsCategory.fish
        physicsBody = body
    }

    // MARK: - Движение

    func moveForward() {
        let verticalSpeed = isJumping ? jumpBoostSpeed : forwardSpeed
        physicsBody?.velocity.dy = verticalSpeed

        startWalkingAnimationIfNeeded()
    }

    func moveHorizontally(byDelta deltaX: CGFloat) {
        position.x += deltaX
    }

    func jump() {
        guard !isJumping else { return }
        isJumping = true

        let scaleUp = SKAction.scale(to: 1.15, duration: jumpDuration / 2)
        let scaleDown = SKAction.scale(to: 1.0, duration: jumpDuration / 2)
        run(SKAction.sequence([scaleUp, scaleDown]))

        run(SKAction.wait(forDuration: jumpDuration)) { [weak self] in
            self?.isJumping = false
        }
    }

    // MARK: - Анимация: запуск / остановка

    private func startWalkingAnimationIfNeeded() {
        guard !loadRunFrames.isEmpty else { return }
        guard action(forKey: "walk") == nil else { return } // уже играет

        let animate = SKAction.animate(with: loadRunFrames, timePerFrame: 0.08)
        let loop = SKAction.repeatForever(animate)
        run(loop, withKey: "walk")
    }

    func stopWalkingAnimation() {
        removeAction(forKey: "walk")
    }
}
