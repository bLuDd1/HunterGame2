import SpriteKit

class GameScene: SKScene {
    
    var background1: SKSpriteNode!
    var background2: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        // Create and position the first background
        background1 = SKSpriteNode(imageNamed: "game_background_3")
        background1.position = CGPoint(x: 0, y: 0)
        background1.zPosition = -1
        background1.anchorPoint = CGPoint.zero
        addChild(background1)
        
        // Create and position the second background
        background2 = SKSpriteNode(imageNamed: "game_background_3")
        background2.position = CGPoint(x: background1.size.width, y: 0)
        background2.zPosition = -1
        background2.anchorPoint = CGPoint.zero
        addChild(background2)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Move both backgrounds to the left
        background1.position.x -= 2
        background2.position.x -= 2
        
        // If a background moves completely off-screen, reset its position
        if background1.position.x <= -background1.size.width {
            background1.position.x = background2.position.x + background2.size.width
        }
        
        if background2.position.x <= -background2.size.width {
            background2.position.x = background1.position.x + background1.size.width
        }
    }
}
