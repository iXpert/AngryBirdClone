//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Amr Elnagar on 24/12/2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
   var bird = SKSpriteNode()
   var box1 = SKSpriteNode()
   var box2 = SKSpriteNode()
   var box3 = SKSpriteNode()
   var box4 = SKSpriteNode()
   var box5 = SKSpriteNode()
    
    var isGameStarted = false
    var birdOriginalPosition = CGPoint()
    
    var currentScore = 0
    var currentScoreLabel = SKLabelNode()
    
    
    enum ColliderType: UInt32 {
        case Bird = 1
        case Box = 2
    }
    
    
    override func didMove(to view: SKView) {
     
    
        // configure scene
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        
        
        // configure bird
        bird = childNode(withName: "bird") as! SKSpriteNode
        let birdTexture = SKTexture(imageNamed: "bird")
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 13)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        birdOriginalPosition = bird.position
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        
        
        
        
        // configure boxes
        
        let boxTexture = SKTexture(imageNamed: "brick")
        let boxSize = CGSize(width: boxTexture.size().width/8, height: boxTexture.size().height/8)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = 0.4
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = 0.4
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = 0.4
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = 0.4
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = 0.4
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        // configure the score label
        currentScoreLabel.fontName = "Helvetica"
        currentScoreLabel.fontSize = 60
        currentScoreLabel.text = "0"
        currentScoreLabel.position = CGPoint(x: 0, y: self.frame.height/4)
        currentScoreLabel.zPosition = 2
        self.addChild(currentScoreLabel)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /* the following is a sample code to demonstrate how to move the bird around by applying impulse
         
        bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100))
        bird.physicsBody?.affectedByGravity = true
        */
        
        // allow the user to drag the bird to a location on the scene
        
        if isGameStarted == false {
            
            if let touch = touches.first {
                
                // get the location of the touch
                let touchLocation = touch.location(in: self)
                // check which nodes the user has touched in that location
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for touchNode in touchNodes {
                        
                        // convert to SKSpritNode
                        if let spriteNode = touchNode as? SKSpriteNode {
                            
                            // check if the user touched the bird
                            if spriteNode == bird {
                                // let the location of the bird follow the user mouse
                                bird.position = touchLocation
                            }
                        }
                    }
                }
                
            }
        }
        
        
        
         
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // allow the user to drag the bird to a location on the scene
        
        if isGameStarted == false {
            
            if let touch = touches.first {
                
                // get the location of the touch
                let touchLocation = touch.location(in: self)
                // check which nodes the user has touched in that location
                let touchNodes = nodes(at: touchLocation)
                
                for touchNode in touchNodes {
                    
                    // convert to SKSpritNode
                    if let spriteNode = touchNode as? SKSpriteNode {
                        
                        // check if the user touched the bird
                        if spriteNode == bird {
                            // let the location of the bird follow the user mouse
                            bird.position = touchLocation
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isGameStarted == false {
            
            if let touch = touches.first {
                
                // get the location of the touch
                let touchLocation = touch.location(in: self)
                // check which nodes the user has touched in that location
                let touchNodes = nodes(at: touchLocation)
                
                for touchNode in touchNodes {
                    
                    // convert to SKSpritNode
                    if let spriteNode = touchNode as? SKSpriteNode {
                        
                        // check if the user touched the bird
                        if spriteNode == bird {
                            // Here we want to apply an impulse on the bird. This can be done by applying a vector force in the opposite direction of the mouse drag
                            
                            // calculate the deltaX and deltaY between the location now and the original position
                            let deltaX = touchLocation.x - birdOriginalPosition.x
                            let deltaY = touchLocation.y - birdOriginalPosition.y
                            
                            // define the impulse vector
                            let impulseVector = CGVector(dx: -deltaX, dy: -deltaY) // the '-' are added since we want to apply a vector impulse in the opposite direction
                            
                            // apply the impulse on the bird
                            bird.physicsBody?.applyImpulse(impulseVector)
                            bird.physicsBody?.affectedByGravity = true
                            
                            // indicate that the game has started to prevent the user from picking up the bird and placing it elsewhere
                            isGameStarted = true
                        }
                    }
                }
            }
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // this function gets triggered whenever a frame is rendered (i.e. it's always being triggered)
    override func update(_ currentTime: TimeInterval) {
        
        if let birdPhysicsBody = bird.physicsBody { // this is to get rid of the optionality of physicsBody
            // check if the bird is about to stop
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 &&
                birdPhysicsBody.angularVelocity <= 0.1 && isGameStarted == true {
               
                // reset the bird to its original position
                bird.physicsBody?.angularVelocity = 0
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = birdOriginalPosition
                isGameStarted = false
            
            }
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            currentScore += 1
            currentScoreLabel.text = String(currentScore)
        }
    }
    
    
    
}
