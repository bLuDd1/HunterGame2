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
                    NavigationLink(destination: MapView()) {
                        Image("play1")
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
