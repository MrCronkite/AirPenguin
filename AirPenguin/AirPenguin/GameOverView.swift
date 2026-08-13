//
//  GameOverView.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SwiftUI

struct GameOverView: View {
    let onRestart: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Game Over")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Button(action: onRestart) {
                    Text("Начать сначала")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40)
            }
        }
    }
}
