//
//  GameScene.swift
//  HunterGame2
//
//  Created by Dima Tavlui on 14.08.2024.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    // Textures
    var playerTexture: SKTexture!
    var candyTextures: [SKTexture]!
    var bombTexture: SKTexture!
    
    // Properties
    var player = SKSpriteNode()
    var scoreLabel: SKLabelNode!
    var livesLabel: SKLabelNode!
    var score = 0
    var lives = 3
    
    var isTouching = false
    
    let playerCategory: UInt32 = 0x1 << 0
    let candyCategory: UInt32 = 0x1 << 1
    let bombCategory: UInt32 = 0x1 << 2
    
    override func didMove(to view: SKView) {
        createBackgroundGame(in: self)
        
        playerTexture = SKTexture(imageNamed: "All Characters-Character07-Fly_00")
        
        self.physicsWorld.contactDelegate = self
        
        player = SKSpriteNode(texture: playerTexture)
        player.size = CGSize(width: 200, height: 200)
        player.position = CGPoint(x: self.frame.midX - 150, y: self.frame.midY)
        player.physicsBody = SKPhysicsBody(texture: playerTexture, size: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = candyCategory | bombCategory
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.isDynamic = true
        self.addChild(player)
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: 100, y: self.frame.height - 40)
        self.addChild(scoreLabel)
        
        livesLabel = SKLabelNode(text: "Lives: 3")
        livesLabel.fontSize = 24
        livesLabel.fontColor = SKColor.black
        livesLabel.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 40)
        self.addChild(livesLabel)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addCandy),
                SKAction.wait(forDuration: 1)
            ])
        ))
                
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addBomb),
                SKAction.wait(forDuration: 5.0)
            ])
        ))
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
    
    func addCandy() {
        candyTextures = [SKTexture(imageNamed: "25"), SKTexture(imageNamed: "31"), SKTexture(imageNamed: "35")]
        let randomTexture = candyTextures.randomElement()!
        let candy = SKSpriteNode(texture: randomTexture)
        candy.size = CGSize(width: 100, height: 75)
        let randomY = CGFloat.random(in: 40...self.frame.height - 40)
        candy.position = CGPoint(x: self.frame.width + candy.size.width, y: randomY)
        candy.physicsBody = SKPhysicsBody(texture: randomTexture, size: candy.size)
        candy.physicsBody?.affectedByGravity = false
        candy.physicsBody?.categoryBitMask = candyCategory
        candy.physicsBody?.contactTestBitMask = playerCategory
        candy.physicsBody?.collisionBitMask = 0
        candy.physicsBody?.isDynamic = true
        self.addChild(candy)
            
        let moveAction = SKAction.moveTo(x: -candy.size.width, duration: 4.0)
        let removeAction = SKAction.removeFromParent()
        candy.run(SKAction.sequence([moveAction, removeAction]))
    }
        
    func addBomb() {
        bombTexture = SKTexture(imageNamed: "bomb")
        let bomb = SKSpriteNode(texture: bombTexture)
        bomb.size = CGSize(width: 50, height: 50)
        let randomY = CGFloat.random(in: 40...self.frame.height - 40)
        bomb.position = CGPoint(x: self.frame.width + bomb.size.width, y: randomY)
        bomb.physicsBody = SKPhysicsBody(rectangleOf: bomb.size)
        bomb.physicsBody?.affectedByGravity = false
        bomb.physicsBody?.categoryBitMask = bombCategory
        bomb.physicsBody?.contactTestBitMask = playerCategory
        bomb.physicsBody?.collisionBitMask = 0
        bomb.physicsBody?.isDynamic = true
        self.addChild(bomb)
        
        let moveAction = SKAction.moveTo(x: -bomb.size.width, duration: 4.0)
        let removeAction = SKAction.removeFromParent()
        bomb.run(SKAction.sequence([moveAction, removeAction]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touch.location(in: self)
            player.physicsBody?.velocity = CGVector(dx: 0, dy: 400)
            isTouching = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouching = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        let halfPlayerHeight = player.size.height / 2
        let screenHeight = self.frame.height
        let screenWidth = self.frame.width
        
        if player.position.y < halfPlayerHeight {
            player.position.y = halfPlayerHeight
            player.physicsBody?.velocity.dy = 0
        } else if player.position.y > screenHeight - halfPlayerHeight {
            player.position.y = screenHeight - halfPlayerHeight
            player.physicsBody?.velocity.dy = 0
        }
        
        if isTouching {
            player.physicsBody?.velocity = CGVector(dx: 0, dy: 300)
        }
    }
        
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == (playerCategory | candyCategory) {
            if let monster = contact.bodyA.categoryBitMask == candyCategory ? contact.bodyA.node : contact.bodyB.node {
                monster.removeFromParent()
                score += 1
                scoreLabel.text = "Score: \(score)"
            }
        } else if contactMask == (playerCategory | bombCategory) {
            if let slime = contact.bodyA.categoryBitMask == bombCategory ? contact.bodyA.node : contact.bodyB.node {
                slime.removeFromParent()
                lives -= 1
                livesLabel.text = "Lives: \(lives)"
                    
                if lives == 0 {
                   print("over")
                }
            }
        }
    }
   
}
