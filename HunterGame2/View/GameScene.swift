//
//  GameScene.swift
//  HunterGame2
//
//  Created by Dima Tavlui on 14.08.2024.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMove(to view: SKView) {
        createBackgroundGame(in: self)
    }
    
    private func createBackgroundGame(in scene: SKScene) {
        let bgTexture = SKTexture(imageNamed: "game_background_3")
        let moveBg = SKAction.moveBy(x: -bgTexture.size().width, y: 0, duration: 15)
        let resetBg = SKAction.moveBy(x: bgTexture.size().width, y: 0, duration: 0)
        let moveBgForever = SKAction.repeatForever(SKAction.sequence([moveBg, resetBg]))
        
        for i in 0...1 {
            let background = SKSpriteNode(texture: bgTexture)
            background.position = CGPoint(x: bgTexture.size().width * CGFloat(i), y: scene.size.height / 2)
            background.size = CGSize(width: bgTexture.size().width, height: scene.size.height)
            background.run(moveBgForever)
            background.zPosition = -1
            
            scene.addChild(background)
        }
    }
        
   
}
