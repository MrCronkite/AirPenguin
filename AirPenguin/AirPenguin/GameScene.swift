//
//  GameScene.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SpriteKit
import UIKit

final class GameScene: SKScene, SKPhysicsContactDelegate {

    var onGameOver: (() -> Void)?
    var onScoreChange: ((Int) -> Void)?

    private var penguin: Penguin!
    private let levelGenerator = LevelGenerator()
    private let cameraNode = SKCameraNode()

    private var iceFloeNodes: [IceFloe] = []
    private var isGameOver = false

    private var score = 0 {
        didSet { onScoreChange?(score) }
    }

    private var spawnedFloeCount = 0
    private var spawnedFishCount = 0
    private let generationLookahead: CGFloat = 1500
    private var waterBackground: WaterBackground!
    private var lastUpdateTime: TimeInterval = 0

    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self

        setupPenguin()
        spawnPendingFloes()
        spawnPendingFish()
        setupCamera()
        setupWaterBackground()
        setupGestures(on: view)
    }

    private func setupWaterBackground() {
        waterBackground = WaterBackground(screenSize: size)
        waterBackground.zPosition = -10
        cameraNode.addChild(waterBackground) // <-- добавляем в камеру, а не в сцену — тогда всегда покрывает экран
    }

    private func setupPenguin() {
        penguin = Penguin()
        penguin.position = levelGenerator.iceFloes[0].position
        addChild(penguin)
    }

    private func spawnPendingFloes() {
        let floes = levelGenerator.iceFloes
        guard spawnedFloeCount < floes.count else { return }

        for floeData in floes[spawnedFloeCount...] {
            let floe = IceFloe(size: floeData.size)
            floe.position = floeData.position
            addChild(floe)
            iceFloeNodes.append(floe)
        }
        spawnedFloeCount = floes.count
    }

    private func spawnPendingFish() {
        let positions = levelGenerator.fishPositions
        guard spawnedFishCount < positions.count else { return }

        for point in positions[spawnedFishCount...] {
            let fish = Fish()
            fish.position = point
            addChild(fish)
        }
        spawnedFishCount = positions.count
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
        updateCamera()
        checkWaterFall()
        checkGenerateMoreFloes()
        waterBackground.update(deltaTime: deltaTime)
    }

    private func checkGenerateMoreFloes() {
        if levelGenerator.lastFloeY - penguin.position.y < generationLookahead {
            levelGenerator.generateNextFloes(count: 10)
            spawnPendingFloes()
            spawnPendingFish()
        }
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

    // MARK: - Жесты

    private func setupGestures(on view: SKView) {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(pan)
    }

    @objc private func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        guard !isGameOver else { return }
        penguin.jump()
    }

    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard !isGameOver else { return }
        guard let view = self.view else { return }

        // translation — смещение с прошлого вызова (UIKit сам считает дельту)
        let translation = recognizer.translation(in: view)
        penguin.moveHorizontally(byDelta: translation.x)

        // Сбрасываем, чтобы в следующий раз получить чистую дельту, а не накопленную с начала жеста
        recognizer.setTranslation(.zero, in: view)
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
