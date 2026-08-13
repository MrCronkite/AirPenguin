//
//  ContentView.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @State private var isGameOver = false
    @State private var score = 0
    @State private var sceneId = UUID()

    var body: some View {
        ZStack {
            SpriteView(scene: makeScene())
                .ignoresSafeArea()
                .id(sceneId)

            ScoreView(score: score)

            if isGameOver {
                GameOverView {
                    restartGame()
                }
            }
        }
    }

    private func makeScene() -> SKScene {
        let scene = GameScene()
        scene.size = UIScreen.main.bounds.size
        scene.scaleMode = .resizeFill
        scene.onGameOver = {
            isGameOver = true
        }
        scene.onScoreChange = { newScore in
            score = newScore
        }
        return scene
    }

    private func restartGame() {
        isGameOver = false
        score = 0
        sceneId = UUID()
    }
}
