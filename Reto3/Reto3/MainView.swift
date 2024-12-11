//
//  MainView.swift
//  Reto3
//
//  Created by Jimena Gallegos on 09/12/24.
//

import SwiftUI

struct MainView: View {
    let size = (UIScreen.main.bounds.width)/2
    let size_height = (UIScreen.main.bounds.height)
    @State private var readyToNavigate : Bool = false
    @State private var selectedPlanet = ""
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                BackgroundComponentView()
                //Color(red: 38/255, green: 50/255, blue: 92/255)
                
                
                ZStack {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [10]))
                        .frame(width: 600)
                    
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [10]))
                        .frame(width: 825)
                    
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [10]))
                        .frame(width: 1050)
                    
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [10]))
                        .frame(width: 1275)
                    
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [10]))
                        .frame(width: 1500, height: 1500)
                    
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [10]))
                        .frame(width: 1725, height: 1725)
                    
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [10]))
                        .frame(width: 1950, height: 1950)
                    
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [10]))
                        .frame(width: 2175, height: 2175)
                }
                .position(x: 140, y: 700)
                
                ZStack{
                    Button {
                        print("Sun button was tapped")
                        selectedPlanet = "Sun"
                        readyToNavigate = true
                    } label: {
                        Image("sun")
                            .resizable()
                            .frame(width: 580, height: 580)
                    }
                    .position(x: 105, y: 740)
                    
                    Button {
                        print("Mercury button was tapped")
                        selectedPlanet = "Mercury"
                        readyToNavigate = true
                    } label: {
                        Image("mercury")
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                    .position(x: 300, y: 450)
                    
                    
                    Button {
                        print("Venus button was tapped")
                        selectedPlanet = "Venus"
                        readyToNavigate = true
                        
                    } label: {
                        Image("venus")
                            .resizable()
                            .frame(width: 120, height: 120)
                    }
                    .position(x: 540, y: 650)
                    
                    Button {
                        print(" Earth button was tapped")
                        selectedPlanet = "Earth"
                        readyToNavigate = true
                    } label: {
                        Image("earth")
                            .resizable()
                            .frame(width: 140, height: 140)
                    }
                    .position(x: 480, y: 310)
                    
                    Button {
                        print("Mars button was tapped")
                        selectedPlanet = "Mars"
                        readyToNavigate = true
                    } label: {
                        Image("mars")
                            .resizable()
                            .frame(width: 85, height: 85)
                    }
                    .position(x: 710, y: 420)
                    
                    Button {
                        print("Jupiter button was tapped")
                        selectedPlanet = "Jupiter"
                        readyToNavigate = true
                    } label: {
                        Image("jupiter")
                            .resizable()
                            .frame(width: 185, height: 185)
                    }
                    .position(x: 880, y: 600)
                    
                    Button {
                        print("Saturn button was tapped")
                        selectedPlanet = "Saturn"
                        readyToNavigate = true
                    } label: {
                        Image("saturn")
                            .resizable()
                            .frame(width: 310, height: 185)
                            .rotationEffect(.degrees(-20))
                    }
                    .position(x: 840, y: 200)
                    
                    Button {
                        print("Uranus button was tapped")
                        selectedPlanet = "Uranus"
                        readyToNavigate = true
                    } label: {
                        Image("uranus")
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                    .position(x: 1040, y: 350)
                    
                    Button {
                        print("Neptune button was tapped")
                        selectedPlanet = "Neptune"
                        readyToNavigate = true
                    } label: {
                        Image("neptune")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .position(x: 1080, y: 150)
                    
                    Text("Click on any planet to see it better")
                        .foregroundStyle(Color.white)
                        .bold()
                        .position(x:size, y:800)
                }
                
                
                
            }
            .ignoresSafeArea()
            .navigationDestination(isPresented: $readyToNavigate) {
                SheetView(isPresented: .constant(true), modelName: selectedPlanet)
                      }
        }
    }
}

#Preview {
    MainView()
}
