//
//  ARViewContainer.swift
//  ARkitTest2
//
//  Created by Jimena Gallegos on 05/12/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    @Binding var modelName: String
    
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
        
        // loadModel using the name
        guard let modelEntity = try? Entity.loadModel(named: modelName) else { return }
        
        // necesita tener esto para las gestures (para que use el hasCollision)
        modelEntity.generateCollisionShapes(recursive: true)

        // add the loaded model to the entity
        anchorEntity.addChild(modelEntity)
        
        // Set the 'view' property of the coordinator to the 'uiView' passed as an argument.
        context.coordinator.view = uiView

        // Create a UILongPressGestureRecognizer to detect long-press gestures.
        let longPressGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(_:)))

       // Add the UILongPressGestureRecognizer to the 'uiView' for user interaction.
       uiView.addGestureRecognizer(longPressGesture)
        
        // instalar los gestures!
        uiView.installGestures([.all], for: modelEntity as Entity & HasCollision)
        
        // add the scene
        uiView.scene.addAnchor(anchorEntity)
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

extension ARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()

        // Goal is a field that indicates your app's tracking requirements.
        coachingOverlay.goal = .horizontalPlane
             
        // The session this view uses to provide coaching.
        coachingOverlay.session = self.session
             
        // How a view should resize itself when its superview's bounds change.
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.addSubview(coachingOverlay)
    }
}
