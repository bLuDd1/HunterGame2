//
//  MapView.swift
//  HunterGame2
//
//  Created by Dima Tavlui on 14.08.2024.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("game_background_3")
                VStack {
                    Image("select")
                        .resizable()
                        .frame(width: 445.5, height: 327.5)
                        .offset(CGSize(width: 0, height: -220.0))
                    
                    NavigationLink(destination: GameView()) {
                        Text("Level 1")
                            .font(.custom("Helvetica", size: 35))
                            .bold()
                            .padding()
                            .foregroundStyle(.white)
                            .background(.pink)
                            .cornerRadius(10)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.white, lineWidth: 2)
                                )
                    }
                    .offset(y: -100)
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MapView()
}
