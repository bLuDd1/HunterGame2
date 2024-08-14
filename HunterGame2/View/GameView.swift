//
//  GameView.swift
//  HunterGame2
//
//  Created by Dima Tavlui on 14.08.2024.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    var scene: SKScene {
        let scene = GameScene()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let screenSize = windowScene.screen.bounds.size
                scene.size = screenSize
        }
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .statusBar(hidden: true)
    }
}

#Preview {
    GameView()
}
