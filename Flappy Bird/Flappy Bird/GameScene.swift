//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Dushko Cizaloski on 4/10/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import SpriteKit
import GameplayKit

//class GameScene: SKScene, SKPhysicsContactDelegate {
//    
//    //Sprite of caracter which moved around of the screen
//    var bird = SKSpriteNode()
//    
//    var bg = SKSpriteNode()
//    
//    var Pipe = SKSpriteNode()
//    
//    var Pipe1 = SKSpriteNode()
//    
//    var score = 0
//    
//    var gameOverLabel = SKLabelNode()
//    
//    var scoreLabel = SKLabelNode()
//    var gameOver = false
//    
//    var timer = Timer()
//    
//    enum ColliderType: UInt32
//    {
//        case Bird = 1
//        case Object = 2
//        case Gap = 4
//    }
//    
//    //This func will creating a new pipes and than will be show out on the screen
//    
//    func makePipes()
//    {
//        //Here we maked to moved a pipes for right to the left
//        
//        let movePipe = SKAction.move(by: CGVector(dx: -2 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width / 100))
//        
//        let removePipes = SKAction.removeFromParent()
//        
//        
//        let moveAndRemovePipes = SKAction.sequence([movePipe, removePipes])
//        
//        //Here i will make some changes i resize picture of birdTexture and subsribe into Pipe and Pipe1
//        
//        let gapHeight = bird.size.height * 4
//        
//        let movmentAmount = arc4random() % UInt32(self.frame.height / 2)
//        
//        let pipeOffset = CGFloat(movmentAmount) - self.frame.height / 4
//        
//        let setPiple = SKTexture(imageNamed: "pipe1.png")
//        
//        
//        Pipe = SKSpriteNode(texture: setPiple)
//        
//        
//        Pipe.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + setPiple.size().height / 2 + gapHeight / 2 + pipeOffset)
//        Pipe.run(moveAndRemovePipes)
//        
//        Pipe.physicsBody = SKPhysicsBody(rectangleOf: setPiple.size())
//        
//        Pipe.physicsBody?.isDynamic = false
//        
//        Pipe.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
//        Pipe.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
//        Pipe.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
//        
//        //Pipe.physicsBody = SKPhysicsBody(circleOfRadius: setPiple.size().height / 2)
//        
//        Pipe.zPosition = -1
//        
//        self.addChild(Pipe)
//        
//        let setPiple1 = SKTexture(imageNamed: "pipe2.png")
//        
//        Pipe1 = SKSpriteNode(texture: setPiple1)
//        
//        Pipe1.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY - setPiple1.size().height / 2 - gapHeight / 2 + pipeOffset)
//        
//        Pipe1.run(moveAndRemovePipes)
//        
//        Pipe1.physicsBody = SKPhysicsBody(rectangleOf: setPiple1.size())
//        
//        Pipe1.physicsBody?.isDynamic = false
//        
//        Pipe1.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
//        Pipe1.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
//        Pipe1.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
//        
//        Pipe1.zPosition = -1
//        
//        self.addChild(Pipe1)
//        
//        let gap = SKNode()
//        
//        gap.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.minY + pipeOffset)
//        
//        gap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: setPiple.size().width, height: gapHeight))
//        
//        gap.physicsBody!.isDynamic = false
//        
//        gap.run(moveAndRemovePipes)
//        
//        gap.physicsBody!.contactTestBitMask = ColliderType.Bird.rawValue
//        gap.physicsBody!.categoryBitMask = ColliderType.Gap.rawValue
//        gap.physicsBody!.collisionBitMask = ColliderType.Gap.rawValue
//        
//        self.addChild(gap)
//    }
//    
//    //This method is used when two object between them have a contact or in our case that is call collision
//    
//    func didBegin(_ contact: SKPhysicsContact) {
//        
//        if gameOver == false
//        {
//        
//        if contact.bodyA.categoryBitMask == ColliderType.Gap.rawValue || contact.bodyB.categoryBitMask == ColliderType.Gap.rawValue
//        {
//            
//            score += 1
//            
//            scoreLabel.text = String(score)
//            
//        }
//        else
//        {
//        
//        self.speed = 0
//        
//        gameOver = true
//            
//        timer.invalidate()//stop the timer
//            
//        gameOverLabel.fontName = "Helvetica"
//            
//        gameOverLabel.fontSize = 30
//            
//        gameOverLabel.text = "Game Over! Tap to play again"
//            
//        gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//            
//        self.addChild(gameOverLabel)
//            
//            }
//        
//        }
//    }
//    
//    override func didMove(to view: SKView) {
//        
//        self.physicsWorld.contactDelegate = self
//        
//        setupGame()
//        
//    }
//    
//    func setupGame()
//    {
//        
//        
//        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.makePipes), userInfo: nil, repeats: true)
//        
//        
//        let bgTexture = SKTexture(imageNamed: "bg.png")
//        
//        //Here now we will make to moved  a background and that is for make a illusion for a bird and think that are moved on the image
//        //move background for -1 to a x ordinate for 0.1 secound
//        let moveBGAnimation = SKAction.move(by: CGVector(dx: -bgTexture.size().width, dy: 0), duration: 7)
//        
//        //Here we implement another code where show us how to solved a problem with repeate a background again and again
//        let shiftBGAnimation = SKAction.move(by: CGVector(dx: bgTexture.size().width, dy: 0), duration: 0)
//        
//        let makeBGAnimationMoveForever = SKAction.repeatForever(SKAction.sequence([moveBGAnimation, shiftBGAnimation]))
//        
//        var i : CGFloat = 0
//        
//        while i < 3 {
//            
//            bg = SKSpriteNode(texture: bgTexture)
//            
//            bg.position = CGPoint(x: bgTexture.size().width * i, y: self.frame.midY)
//            
//            bg.size.height = self.frame.height
//            
//            bg.run(makeBGAnimationMoveForever)
//            
//            bg.zPosition = -2
//            
//            self.addChild(bg)
//            
//            i += 1
//        }
//        
//        
//        //here we add flappy bird on the screen
//        
//        let birdTexture = SKTexture(imageNamed: "flappy1.png")
//        //How will make the bird be flappy
//        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
//        
//        let animate = SKAction.animate(with: [birdTexture, birdTexture2], timePerFrame: 0.1)
//        
//        //Here we make to animation to repeat forever about for 0.1 secounds
//        
//        let makeBirdFlap = SKAction.repeatForever(animate)
//        bird = SKSpriteNode(texture: birdTexture)
//        
//        //Here we put some code for bird go up and down or when user press on the screen the bird go up and when user stop pressed she is going down
//        
//        
//        //The picture of the bird while be on the middel of the screen of x and y coordinate points
//        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//        
//        //This is the same code for adding backgroun image and thay are to short
//        
//        //        let background = SKSpriteNode(imageNamed: "bg.png")
//        //
//        //        background.scale(to: CGSize(width: size.width, height: size.height))
//        //
//        //        self.addChild(background)
//        
//        bird.run(makeBirdFlap)
//        
//        //Thay are may contact with object of same type.
//        
//        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2)
//        
//        bird.physicsBody?.isDynamic = false
//        
//        bird.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
//        bird.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
//        bird.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
//        
//        //here bird will be added on the view
//        self.addChild(bird)
//        
//        //We now set a groud where we set a rules when bird touch the ground bird stop to moved and the game will stoped and get the result for bird how much points she is get it
//        
//        let ground = SKNode()
//        
//        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height / 2)
//        
//        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
//        
//        ground.physicsBody?.isDynamic = false
//        
//        ground.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
//        ground.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
//        ground.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
//        
//        self.addChild(ground)
//        
//        scoreLabel.fontName = "Helvetica"
//        
//        scoreLabel.fontSize = 60
//        
//        scoreLabel.text = "0"
//        
//        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.height / 2 - 70)
//        
//        self.addChild(scoreLabel)
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//       
//        if gameOver == false
//        {
//        
//        bird.physicsBody?.isDynamic = true
//      /*
//                here we add flappy bird on the screen
//        
//                let birdTexture = SKTexture(imageNamed: "flappy1.png")
//        
//                Here we put some code for bird go up and down or when user press on the screen the bird go up and when user stop pressed she is going down
//        
//                bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2) //This will be draw invisible circle around of the bird
//        
//            The bird will go down when user start touch the screen
//            bird.physicsBody?.isDynamic = true
//                Here we make to speed of bird to be a 0
//        */
//        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
//        
//       //If we don't like to bird go down we will set a vector coordinate and x coordinate line will be 0 but y coordinate line we will set to go up for 50 pixels
//        
//       bird.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 80))
//        }
//        else
//        {
//            gameOver = false
//            
//            score = 0
//            
//            self.speed = 1
//            
//            self.removeAllChildren()
//            
//            setupGame()
//        }
//      
//        
//    }
//    
//    
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
//}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    
    var bg = SKSpriteNode()
    
    var scoreLabel = SKLabelNode()
    
    var score = 0
    
    var gameOverLabel = SKLabelNode()
    
    var timer = Timer()
    
    enum ColliderType: UInt32 {
        
        case Bird = 1
        case Object = 2
        case Gap = 4
        
    }
    
    var gameOver = false
    
    func makePipes() {
        
        let movePipes = SKAction.move(by: CGVector(dx: -2 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width / 100))
        let removePipes = SKAction.removeFromParent()
        let moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
        
        let gapHeight = bird.size.height * 4
        
        let movementAmount = arc4random() % UInt32(self.frame.height / 2)
        
        let pipeOffset = CGFloat(movementAmount) - self.frame.height / 4
        
        let pipeTexture = SKTexture(imageNamed: "pipe1.png")
        
        let pipe1 = SKSpriteNode(texture: pipeTexture)
        
        pipe1.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeTexture.size().height / 2 + gapHeight / 2 + pipeOffset)
        
        pipe1.run(moveAndRemovePipes)
        
        pipe1.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipe1.physicsBody!.isDynamic = false
        
        pipe1.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        pipe1.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        pipe1.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        pipe1.zPosition = -1
        
        self.addChild(pipe1)
        
        let pipe2Texture = SKTexture(imageNamed: "pipe2.png")
        
        let pipe2 = SKSpriteNode(texture: pipe2Texture)
        
        pipe2.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY - pipe2Texture.size().height / 2 - gapHeight / 2 + pipeOffset)
        
        pipe2.run(moveAndRemovePipes)
        
        pipe2.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipe2.physicsBody!.isDynamic = false
        
        pipe2.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        pipe2.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        pipe2.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        pipe2.zPosition = -1
        
        self.addChild(pipe2)
        
        let gap = SKNode()
        
        gap.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeOffset)
        
        gap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: pipeTexture.size().width, height: gapHeight))
        
        gap.physicsBody!.isDynamic = false
        
        gap.run(moveAndRemovePipes)
        
        gap.physicsBody!.contactTestBitMask = ColliderType.Bird.rawValue
        gap.physicsBody!.categoryBitMask = ColliderType.Gap.rawValue
        gap.physicsBody!.collisionBitMask = ColliderType.Gap.rawValue
        
        self.addChild(gap)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if gameOver == false {
            
            if contact.bodyA.categoryBitMask == ColliderType.Gap.rawValue || contact.bodyB.categoryBitMask == ColliderType.Gap.rawValue {
                
                score += 1
                
                scoreLabel.text = String(score)
                
                
            } else {
                
                self.speed = 0
                
                gameOver = true
                
                timer.invalidate()
                
                gameOverLabel.fontName = "Helvetica"
                
                gameOverLabel.fontSize = 30
                
                gameOverLabel.text = "Game Over! Tap to play again."
                
                gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                
                self.addChild(gameOverLabel)
                
            }
            
        }
        
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        setupGame()
        
    }
    
    func setupGame() {
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.makePipes), userInfo: nil, repeats: true)
        
        let bgTexture = SKTexture(imageNamed: "bg.png")
        
        let moveBGAnimation = SKAction.move(by: CGVector(dx: -bgTexture.size().width, dy: 0), duration: 7)
        let shiftBGAnimation = SKAction.move(by: CGVector(dx: bgTexture.size().width, dy: 0), duration: 0)
        let moveBGForever = SKAction.repeatForever(SKAction.sequence([moveBGAnimation, shiftBGAnimation]))
        
        var i: CGFloat = 0
        
        while i < 3 {
            
            bg = SKSpriteNode(texture: bgTexture)
            
            bg.position = CGPoint(x: bgTexture.size().width * i, y: self.frame.midY)
            
            bg.size.height = self.frame.height
            
            bg.run(moveBGForever)
            
            bg.zPosition = -2
            
            self.addChild(bg)
            
            i += 1
            
        }
        
        
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        let animation = SKAction.animate(with: [birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture)
        
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        bird.run(makeBirdFlap)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2)
        
        bird.physicsBody!.isDynamic = false
        
        bird.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        bird.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        self.addChild(bird)
        
        let ground = SKNode()
        
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height / 2)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        
        ground.physicsBody!.isDynamic = false
        
        ground.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        ground.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        ground.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        self.addChild(ground)
        
        scoreLabel.fontName = "Helvetica"
        
        scoreLabel.fontSize = 60
        
        scoreLabel.text = "0"
        
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.height / 2 - 70)
        
        self.addChild(scoreLabel)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameOver == false {
            
            bird.physicsBody!.isDynamic = true
            
            bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
            
            bird.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 50))
            
        } else {
            
            gameOver = false
            
            score = 0
            
            self.speed = 1
            
            self.removeAllChildren()
            
            setupGame()
            
            
        }
        
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
}
