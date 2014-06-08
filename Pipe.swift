//
//  Pipe.swift
//  FlappyBird
//
//  Created by Thomas Pedersen on 6/7/14.
//  Copyright (c) 2014 Thomas Pedersen. All rights reserved.
//

import Foundation
import SpriteKit

class Pipe: SKNode{
    
    var top:SKSpriteNode, bottom:SKSpriteNode
    var height:CGFloat
    
    init(x:Int){
        top = SKSpriteNode(imageNamed:"topPipe")
        bottom = SKSpriteNode(imageNamed:"bottomPipe")
        top.setScale(4.45)
        bottom.setScale(4.45)
        top.normalTexture = top.texture.textureByGeneratingNormalMapWithSmoothness(0.5, contrast: 5)
        bottom.normalTexture = bottom.texture.textureByGeneratingNormalMapWithSmoothness(0.5, contrast: 5)

        height = CGFloat((rand()%500))+450.0
        //top.lightingBitMask = 1
        //bottom.lightingBitMask = 1
        top.shadowCastBitMask = 1
        bottom.shadowCastBitMask = 1
        top.position = CGPointMake(0, height+280+100)
        bottom.position = CGPointMake(0, height-280-100)
        super.init()
        position = CGPointMake(1024.0+CGFloat(x)*300.0, 0)
        self.addChild(top)
        self.addChild(bottom)
        self.zPosition = 2
    }
    /*init(){
        super.init()
    }*/
    
    
    
}