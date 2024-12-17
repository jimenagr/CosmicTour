//
//  SheetView.swift
//  ARkitTest2
//
//  Created by Jimena Gallegos on 05/12/24.
//

import SwiftUI

struct SheetView: View {
    
    // si presente mostrar la view
    @Binding var isPresented: Bool
    // create modelName
    @State var modelName: String = "Sun"
    //@State var modelName: String = "toy_biplane_idle"
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            // Poner la vista del modelo 3d
            ARViewContainer(modelName: $modelName)
                .ignoresSafeArea(edges: .all)
            
            // boton para cerrar
            /*Button() {
                isPresented.toggle()
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(24)*/
    }
    }
}

#Preview {
    SheetView(isPresented: .constant(true), modelName: "Sun")
}
