//
//  SheetViewCompleteSolarSytem.swift
//  Reto3
//
//  Created by Jimena Gallegos on 17/12/24.
//

import SwiftUI

struct SheetViewCompleteSolarSytem: View {
    @State private var velocityPercent: Double = 1.0
    let starCount = 100
    let starPositions = (0..<100).map { _ in
        CGPoint(
            x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
            y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
        )
    }

    var body: some View {
        ZStack {
            // Fondo azul oscuro
            ARViewCompleteSystemContainer(timeVelocity: $velocityPercent)
                .accessibilityLabel("Solar system model")
            
            Color(red: 38/255, green: 50/255, blue: 92/255)
                .opacity(0.3)

            ForEach(0..<starCount, id: \.self) { index in
                Image(systemName: "star.fill")
                    .foregroundStyle(Color.white.opacity(0.3))
                    .scaleEffect(1)
                    .position(x: starPositions[index].x, y: starPositions[index].y)
            }
            .opacity(0.3)

            //ARViewCompleteSystemContainer(timeVelocity: $velocityPercent)

            VStack {
                Spacer()
                Slider(value: $velocityPercent, in: 0.1...3)
                    .frame(width: 400)
                    .accessibilityLabel("Velocidad")
                    .accessibilityValue("\(String(format: "%.1f", velocityPercent)) the normal velocity")
                    .accessibilityHint("Adjust the velocity for faster or slower")
                
                Text("Adjust the velocity")
            }
            .padding(.bottom, 50)
        }
        .ignoresSafeArea()
    }
}


#Preview {
    SheetViewCompleteSolarSytem()
}
