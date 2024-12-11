import SwiftUI

struct BackgroundComponentView: View {
    @State var animationValue: Double = 0
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
            Color(red: 38/255, green: 50/255, blue: 92/255)
            
            ForEach(0..<starCount, id: \.self) { index in
                Image(systemName: "star.fill")
                    .foregroundStyle(Color.white.opacity(0.3))
                    .scaleEffect(animationValue)
                    .position(x: starPositions[index].x, y: starPositions[index].y)
                    .animation(
                        .easeInOut(duration: TimeInterval(Int.random(in: 2..<5)))
                        .repeatForever(autoreverses: true),
                        value: animationValue
                    )
            }
        }
        .onAppear {
            animationValue = 1 // Iniciar la animación
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundComponentView()
}
