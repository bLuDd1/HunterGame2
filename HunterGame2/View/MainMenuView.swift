//
//  ContentView.swift
//  HunterGame2
//
//  Created by Dima Tavlui on 14.08.2024.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("game_background_3")
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 250)
                        .offset(y: -200)
                        
                    
                    NavigationLink(destination: MapView()) {
                        Image("play1")
                            .offset(y: -50)
                            
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    MainMenuView()
}
