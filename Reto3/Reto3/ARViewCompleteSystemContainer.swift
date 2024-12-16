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
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    //@Binding var modelName: String
    
    // Create a view object and its initial state
    func makeUIView(context: Context) -> ARView {
        
        // ArView object to display the rendered 3D model to the user
        let arView = ARView(frame: .zero)
        
        // Create configuration object to set up how to track the real world
        let config = ARWorldTrackingConfiguration()
        // detect flat superfices, AQUI SE DEFINE LA ORIENTACION!!!!
        config.planeDetection = [.horizontal,.vertical]
        // provide realistic imagebased lighting
        config.environmentTexturing = .automatic
        
        arView.session.run(config)
        arView.addCoaching()
        return arView
    }
    
    

    // Update the state of the view with the new information from Swift
    func updateUIView(_ uiView: ARView, context: Context) {
        // create Anchor to pin te content somewhere
        let anchorEntity = AnchorEntity(plane: .any)
        
        // loadModeles using the names
        guard let modelSun = try? Entity.loadModel(named: "Sun") else { return }
        guard let modelMercury = try? Entity.loadModel(named: "Mercury") else { return }
        guard let modelVenus =  try? Entity.loadModel(named: "Venus") else { return }
        guard let modelEarth = try? Entity.loadModel(named: "Earth") else { return }
        guard let modelMars = try? Entity.loadModel(named: "Mars") else { return }
        guard let modelJupiter = try? Entity.loadModel(named: "Jupiter") else { return }
        guard let modelSaturn = try? Entity.loadModel(named: "Saturn") else { return }
        guard let modelUranus = try? Entity.loadModel(named: "Uranus") else { return }
        guard let modelNeptune = try? Entity.loadModel(named: "Neptune") else { return }
        
        
        modelSun.generateCollisionShapes(recursive: true)
        modelMercury.generateCollisionShapes(recursive: true)
        modelVenus.generateCollisionShapes(recursive: true)
        modelEarth.generateCollisionShapes(recursive: true)
        modelMars.generateCollisionShapes(recursive: true)
        modelJupiter.generateCollisionShapes(recursive: true)
        modelSaturn.generateCollisionShapes(recursive: true)
        modelUranus.generateCollisionShapes(recursive: true)
        modelNeptune.generateCollisionShapes(recursive: true)

        // add the loaded model to the entity
        anchorEntity.addChild(modelSun)
        anchorEntity.addChild(modelMercury)
        anchorEntity.addChild(modelVenus)
        anchorEntity.addChild(modelEarth)
        anchorEntity.addChild(modelMars)
        anchorEntity.addChild(modelJupiter)
        anchorEntity.addChild(modelSaturn)
        anchorEntity.addChild(modelUranus)
        anchorEntity.addChild(modelNeptune)
        
        // Set the 'view' property of the coordinator to the 'uiView' passed as an argument.
        context.coordinator.view = uiView
        uiView.scene.addAnchor(anchorEntity)
        
        //transform the scale and places
        var transformSun = modelSun.transform
        transformSun.scale = SIMD3<Float>(0.8, 0.8, 0.8)
        transformSun.translation = SIMD3<Float>(0, 0.4, 0.0)
        modelSun.transform = transformSun
        
        var transformMercury = modelMercury.transform
        transformMercury.scale = SIMD3<Float>(0.028, 0.028, 0.028)
        transformMercury.translation = SIMD3<Float>(0.38, 0.636, 0)
        modelMercury.transform = transformMercury
        
        var transformVenus = modelVenus.transform
        transformVenus.scale = SIMD3<Float>(0.070, 0.070, 0.070)
        transformVenus.translation = SIMD3<Float>(0.51,0.615, 0)
        modelVenus.transform = transformVenus
        
        var transformEarth = modelEarth.transform
        transformEarth.scale = SIMD3<Float>(0.074, 0.074, 0.074)
        transformEarth.translation = SIMD3<Float>(0.60, 0.613, 0)
        modelEarth.transform = transformEarth
        
        var transformMars = modelMars.transform
        transformMars.scale = SIMD3<Float>(0.039, 0.039, 0.039)
        transformMars.translation = SIMD3<Float>(0.72, 0.6305, 0)
        modelMars.transform = transformMars
        
        
        var transformJupiter = modelJupiter.transform
        transformJupiter.scale = SIMD3<Float>(0.300, 0.300, 0.300)
        transformJupiter.translation = SIMD3<Float>(1.1, 0.5, 0)
        modelJupiter.transform = transformJupiter
        
        var transformSaturn = modelSaturn.transform
        transformSaturn.scale = SIMD3<Float>(0.250, 0.250, 0.250)
        transformSaturn.translation = SIMD3<Float>(1.36, 0.525, 0)
        modelSaturn.transform = transformSaturn
        
        var transformUranus = modelUranus.transform
        transformUranus.scale = SIMD3<Float>(0.100, 0.100, 0.100)
        transformUranus.translation = SIMD3<Float>(1.75, 0.6, 0)
        modelUranus.transform = transformUranus
        
        var transformNeptune = modelNeptune.transform
        transformNeptune.scale = SIMD3<Float>(0.095, 0.095, 0.095)
        transformNeptune.translation = SIMD3<Float>(2.2, 0.6025, 0)
        modelNeptune.transform = transformNeptune
        
        let animationDefinition = OrbitAnimation(duration: 5, axis: [0, -5, 0], startTransform: modelMercury.transform, bindTarget: .transform, repeatMode: .repeat)
        let animationResource = try! AnimationResource.generate(with: animationDefinition)
        modelMercury.playAnimation(animationResource)
        
        /*
        // Retrieve the current transformation of the model entity
        
        var transform = modelEntity.transform

        // Update the translation component of the transform to move the entity
        
        transform.translation = [0.1, 0, 0]

        // Define an orbit animation
        let animationDefinition = OrbitAnimation(duration: 5, axis: [0, 1, 0], startTransform: transform, bindTarget: .transform)
        
        let animationResource = try! AnimationResource.generate(with: animationDefinition)

        modelEntity.playAnimation(animationResource)
         */
    }
    
    // Creating the Coordinator class GESTURES PERSONALIZADOS
     class Coordinator: NSObject {
       var view: ARView?
         
         //  funcion para cuando se preciona por mucho tiempo y quita el objeto
         @objc
             func handleLongPress(_ recognizer: UITapGestureRecognizer? = nil) {
                 // Check if there is a view to work with
                 guard let view = self.view else { return }

                 // Obtain the location of a tap or touch gesture
                 let tapLocation = recognizer!.location(in: view)

                 // Checking if there's an entity at the tapped location within the view
                 if let entity = view.entity(at: tapLocation) as? ModelEntity {
           
                     // Check if this entity is anchored to an anchor
                         if let anchorEntity = entity.anchor {
                             // Remove the model from the scene
                             anchorEntity.removeFromParent()
                         }
                 }
             }
         
     }
}
