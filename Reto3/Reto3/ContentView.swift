//
//  ContentView.swift
//  Reto3
//
//  Created by Jimena Gallegos on 09/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var timeVelocity: Double = 1.0

    var body: some View {
        MainView()
        //ARViewCompleteSystemContainer(timeVelocity: $timeVelocity)                
        //SheetViewCompleteSolarSytem()
    }
}

#Preview {
    ContentView()
}
