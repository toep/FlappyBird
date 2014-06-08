//
//  GameScene.swift
//  Flappy
//
//  Created by Thomas Pedersen on 6/7/14.
//  Copyright (c) 2014 Thomas Pedersen. All rights reserved.
//

import SpriteKit

let brd:SKSpriteNode = SKSpriteNode(imageNamed:"bird1")
let ground1:SKSpriteNode = SKSpriteNode(imageNamed:"ground")
let ground2:SKSpriteNode = SKSpriteNode(imageNamed:"ground")
let pipes:NSMutableArray = NSMutableArray(capacity: 4)
let numbers:NSMutableArray = NSMutableArray(capacity:10)

var score:Int = 0
var numSprite1:SKSpriteNode = SKSpriteNode(imageNamed:"0")
var numSprite2:SKSpriteNode = SKSpriteNode(imageNamed:"0")

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        brd.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures([
            SKTexture(imageNamed: "bird1"),
            SKTexture(imageNamed: "bird2"),
            SKTexture(imageNamed: "bird3"),
            SKTexture(imageNamed: "bird2")], timePerFrame: 0.04)))
        brd.position = CGPointMake(scene.size.width/2, 400)
        //brd.setScale(4.45)
        brd.zPosition = 4
        brd.physicsBody = SKPhysicsBody(texture: brd.texture, size: brd.texture.size())
        var light:SKLightNode = SKLightNode()
        light.categoryBitMask = 1
        //light.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        brd.addChild(light)
        let an = SKRange(lowerLimit: -M_PI_2, upperLimit: M_PI_4/2)
        brd.constraints = [SKConstraint.zRotation(an), SKConstraint.positionY(SKRange(lowerLimit: 255))]
        self.addChild(brd)
        
        ground1.size = CGSizeMake(685, 250)
        ground2.size = CGSizeMake(685, 250)
        ground1.lightingBitMask = 1
        ground2.lightingBitMask = 1
        ground1.shadowCastBitMask = 1
        ground2.shadowCastBitMask = 1
        ground1.zPosition = 3
        ground2.zPosition = 3
        ground1.position = CGPointMake(342, 125)
        ground2.position = CGPointMake(1027, 125)
        
        self.addChild(ground1)
        self.addChild(ground2)
        for i in 0..4 {
            pipes[i] = Pipe(x:i)
        }
        for i in 0..4 {
            self.addChild(pipes[i] as SKNode)
        }
        for i in 0...9 {
            numbers[i] = SKSpriteNode(imageNamed:"\(i)")
        }
        scene.physicsWorld.gravity = CGVectorMake(0, -13)
        //numSprite1.setScale(6)
        numSprite1.zPosition = 4
        numSprite1.position = CGPointMake(scene.size.width/2, 900)
        //numSprite2.setScale(6)
        numSprite2.zPosition = 4
        numSprite2.position = CGPointMake(scene.size.width/2+42, 900)
        self.addChild(numSprite1)
        self.addChild(numSprite2)
    }
   /* init(){
        for i in 0..4 {
            pipes[i] = (Pipe(x:i))
        }
        super.init()
    }*/
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            brd.physicsBody.velocity = CGVectorMake(0.0, 0.0)
            brd.physicsBody.applyImpulse(CGVectorMake(0, 70))
            println(brd.physicsBody.velocity.dy)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        var angle = 0.0
        var d = brd.physicsBody.velocity.dy+400
        //if(d > -100){
        //  angle = 0.5
        //}else{
        angle = (d/(540.0))*M_PI_2
        //}
        // angle = d > 0 ? (d/742.168)*M_PI_2 : (d/542.168)*M_PI_2
        if angle < -M_PI_2 {angle = -M_PI_2}
        //} else {
        //  angle = (d/242.168)*M_PI_2
        //}
        //println(angle)
        brd.runAction(SKAction.rotateToAngle(angle, duration: 0.0))
        
        var g1x = ground1.position.x-1<=(-340) ? 1024 : ground1.position.x-4
        var g2x = ground2.position.x-1<=(-340) ? 1024 : ground2.position.x-4

        ground1.position = CGPointMake(g1x, ground1.position.y)
        ground2.position = CGPointMake(g2x, ground2.position.y)

        for i: AnyObject in pipes {
            var p:Pipe = (i as Pipe)
            p.position.x-=4
            if(p.position.x == 320){
                score++;
                var scoreStr = String(score)
                var chars:Character[] = []
                for char in scoreStr {
                    chars+=char
                }
                if countElements(chars) == 1{
                    numSprite2.texture = SKTexture(imageNamed: "\(chars[0])")
                }
                if countElements(chars) == 2 {
                    numSprite1.texture = SKTexture(imageNamed: "\(chars[0])")
                    numSprite2.texture = SKTexture(imageNamed: "\(chars[1])")

                }
            }
            if p.position.x < -320 {
                
                p.position.x = (fathest(pipes)+300.0)
            }
        }
        /* Called before each frame is rendered */
    }
    
    func fathest(arr:NSMutableArray) -> CGFloat{
        var fa = 0.0
        for i:AnyObject in arr {
            var p:Pipe = i as Pipe
            if p.position.x > fa {
                fa = p.position.x
            }
        }
        return fa
    }
}
