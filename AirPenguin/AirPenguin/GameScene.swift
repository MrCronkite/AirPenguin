//
//  GameScene.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SpriteKit

final class GameScene: SKScene, SKPhysicsContactDelegate {

    var onGameOver: (() -> Void)?
    var onScoreChange: ((Int) -> Void)?

    private var penguin: Penguin!
    private let levelGenerator = LevelGenerator()
    private let cameraNode = SKCameraNode()

    private var touchStartPoint: CGPoint?
    private var currentTouchX: CGFloat?
    private let swipeUpThreshold: CGFloat = 40

    private var iceFloeNodes: [IceFloe] = []
    private var isGameOver = false
    private var lastUpdateTime: TimeInterval = 0

    private var score = 0 {
        didSet { onScoreChange?(score) }
    }

    override func didMove(to view: SKView) {
        backgroundColor = SKColor(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0)
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self

        setupPenguin()
        setupIceFloes()
        setupFish()
        setupCamera()
    }

    private func setupPenguin() {
        penguin = Penguin()
        penguin.position = CGPoint(
            x: 200,
            y: 150
        )
        addChild(penguin)
    }

    private func setupIceFloes() {

        for floeData in levelGenerator.iceFloes {

            let floe = IceFloe(
                size: floeData.size
            )

            floe.position = floeData.position

            addChild(floe)

            iceFloeNodes.append(floe)
        }
    }

    private func setupFish() {

        for point in levelGenerator.fishPositions {

            let fish = Fish()

            fish.position = point

            addChild(fish)
        }
    }

    private func setupCamera() {
        camera = cameraNode
        addChild(cameraNode)
        cameraNode.position = penguin.position
    }

    override func update(_ currentTime: TimeInterval) {
        guard !isGameOver else { return }

        let deltaTime = lastUpdateTime == 0 ? 0 : currentTime - lastUpdateTime
        lastUpdateTime = currentTime

       penguin.moveForward()

        if let targetX = currentTouchX {
            penguin.moveHorizontally(towards: targetX, deltaTime: deltaTime)
        }

        updateCamera()
        checkWaterFall()
    }

    private func updateCamera() {
        cameraNode.position.y = penguin.position.y
        cameraNode.position.x = penguin.position.x
    }

    private func checkWaterFall() {
        guard !penguin.isJumping else { return }

        let isOnIce = iceFloeNodes.contains { floe in
            floe.frame.contains(penguin.position)
        }

        if !isOnIce {
            triggerGameOver()
        }
    }

    private func triggerGameOver() {
        isGameOver = true
        onGameOver?()
    }

    // MARK: - Touches

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        touchStartPoint = point
        currentTouchX = point.x
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        currentTouchX = point.x
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let start = touchStartPoint,
              let end = touches.first?.location(in: self) else { return }

        if end.y - start.y > swipeUpThreshold {
            penguin.jump()
        }

        touchStartPoint = nil
        currentTouchX = nil
    }

    // MARK: - Contacts

    func didBegin(_ contact: SKPhysicsContact) {
        let bodies = [contact.bodyA, contact.bodyB]

        if let fishBody = bodies.first(where: { $0.categoryBitMask == PhysicsCategory.fish }) {
            fishBody.node?.removeFromParent()
            score += 1
        }

        let hitFinish = bodies.contains { $0.categoryBitMask == PhysicsCategory.finish }
        if hitFinish {
            print("Уровень пройден!")
        }
    }
}
