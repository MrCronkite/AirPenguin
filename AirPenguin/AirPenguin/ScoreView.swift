//
//  ScoreView.swift
//  AirPenguin
//
//  Created by Влад Шимченко on 13.08.2026.
//

import SwiftUI

struct ScoreView: View {
    let score: Int

    var body: some View {
        VStack {
            HStack {
                Text("🐟 \(score)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(12)
                Spacer()
            }
            .padding()
            Spacer()
        }
    }
}
