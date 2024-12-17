//
//  ARViewContainer.swift
//  ARkitTest2
//
//  Created by Jimena Gallegos on 16/12/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewCompleteSystemContainer: UIViewRepresentable {
    @Binding var timeVelocity: Double
    
    class Coordinator: NSObject {
        var view: ARView?
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        // AQUI SE DEFINE LA ORIENTACION!!!!
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        arView.session.run(config)
        arView.addCoaching()
        context.coordinator.view = arView
        
        setupPlanets(in: arView)
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        context.coordinator.view = uiView
        updatePlanetAnimations(uiView: uiView)
    }

    private func setupPlanets(in arView: ARView) {
        // create Anchor to pin te content somewhere
        let anchorEntity = AnchorEntity(plane: .any)
        
        // Cargar modelos
        let planetNames = ["Sun", "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
        for name in planetNames {
            guard let model = try? Entity.loadModel(named: name) else { continue }
            model.name = name
            anchorEntity.addChild(model)
        }

        arView.scene.addAnchor(anchorEntity)

        // Agregar posiciones y escalas
        if let sun = arView.scene.findEntity(named: "Sun") {
            sun.transform = Transform(scale: [0.8, 0.8, 0.8], translation: [0, 0.4, 0])
        }
        if let mercury = arView.scene.findEntity(named: "Mercury") {
            mercury.transform = Transform(scale: [0.028, 0.028, 0.028], translation: [0.38, 0.636, 0])
        }
        if let venus = arView.scene.findEntity(named: "Venus") {
            venus.transform = Transform(scale: [0.07, 0.07, 0.07], translation: [0.51, 0.615, 0])
        }
        if let earth = arView.scene.findEntity(named: "Earth") {
            earth.transform = Transform(scale: [0.074, 0.074, 0.074], translation: [0.60, 0.613, 0])
        }
        if let mars = arView.scene.findEntity(named: "Mars") {
            mars.transform = Transform(scale: [0.039, 0.039, 0.039], translation: [0.72, 0.6305, 0])
        }
        if let jupiter = arView.scene.findEntity(named: "Jupiter") {
            jupiter.transform = Transform(scale: [0.3, 0.3, 0.3], translation: [1.1, 0.5, 0])
        }
        if let saturn = arView.scene.findEntity(named: "Saturn") {
            saturn.transform = Transform(scale: [0.25, 0.25, 0.25], translation: [1.36, 0.525, 0])
        }
        if let uranus = arView.scene.findEntity(named: "Uranus") {
            uranus.transform = Transform(scale: [0.1, 0.1, 0.1], translation: [1.75, 0.6, 0])
        }
        if let neptune = arView.scene.findEntity(named: "Neptune") {
            neptune.transform = Transform(scale: [0.095, 0.095, 0.095], translation: [2.2, 0.6025, 0])
        }
    }

    private func updatePlanetAnimations(uiView: ARView) {
        guard let mercury = uiView.scene.findEntity(named: "Mercury") as? ModelEntity,
              let venus = uiView.scene.findEntity(named: "Venus") as? ModelEntity,
              let earth = uiView.scene.findEntity(named: "Earth") as? ModelEntity,
              let mars = uiView.scene.findEntity(named: "Mars") as? ModelEntity,
              let jupiter = uiView.scene.findEntity(named: "Jupiter") as? ModelEntity,
              let saturn = uiView.scene.findEntity(named: "Saturn") as? ModelEntity,
              let uranus = uiView.scene.findEntity(named: "Uranus") as? ModelEntity,
              let neptune = uiView.scene.findEntity(named: "Neptune") as? ModelEntity else { return }
        
        //Velocidades iniciales de los planetas en relacion a su velocidad real
        let planetData: [(ModelEntity, Double)] = [
            (mercury, 3.62), (venus, 9.25), (earth, 15.0),
            (mars, 28.23), (jupiter, 178.02), (saturn, 441.78),
            (uranus, 1260.71), (neptune, 2472.60)
        ]
        
        //Animacion
        for (entity, duration) in planetData {
            entity.stopAllAnimations()
            let animationDef = OrbitAnimation(
                name: "orbit",
                duration: duration * (1 / timeVelocity),
                axis: [0, 1, 0],
                startTransform: entity.transform,
                spinClockwise: false,
                orientToPath: true,
                rotationCount: 1,
                bindTarget: .transform,
                repeatMode: .repeat
            )
            let animationResource = try! AnimationResource.generate(with: animationDef)
            entity.playAnimation(animationResource)
        }
    }
}

