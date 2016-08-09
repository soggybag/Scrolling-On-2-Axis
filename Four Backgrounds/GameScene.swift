//
//  GameScene.swift
//  Four Backgrounds
//
//  Created by mitchell hudson on 8/8/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//

/*
 
 This example show how to create an endless scrolling background along two axis. 
 
 There are four background sections, really just Spite nodes, each equal in size 
 to the scene view. These should be this size or larger. Background sections that 
 move out of view of the camera move to the left or right, up or down and become 
 the next background section moving into view. In other words, a background section
 moving off the left, as the camera moves to the right, is moved to right side of 
 the currntly visible background section. The same is applied to vertical movement. 
 
 Background sections should be the size of the screen or larger. The example as 
 written here uses the size of the view. If you make background sections larger
 you will need to use that size in the scrollSceneNodes() methods.
 
 */

import SpriteKit

class GameScene: SKScene {
    
    var backgrounds = [SKSpriteNode]()
    let cameraNode: SKCameraNode
    let joystick = Joystick()
    
    override init(size: CGSize) {
        for i in 0 ..< 4 {
            let hue = CGFloat(i) * 1 / 4
            let background = SKSpriteNode(color: UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1), size: size)
            background.position.x = CGFloat(i % 2) * size.width
            background.position.y = CGFloat(i / 2) * size.height
            
            // background.anchorPoint = CGPoint(x: 0, y: 0)
            
            backgrounds.append(background)
        }
        
        cameraNode = SKCameraNode()
        
        super.init(size: size)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setup() {
        for background in backgrounds {
            addChild(background)
        }
        
        addChild(cameraNode)
        camera = cameraNode
        
        cameraNode.addChild(joystick)
    }
    
    
    
    
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        // Show the joystick at the position of the touch.
        // check touch location before showing...
        joystick.show(touches.first!)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Send the joystick move messages to update the stick position.
        joystick.move(touches.first!)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Hide the joystick.
        joystick.hide()
    }
    
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        cameraNode.position.x += 10 * joystick.xValue
        cameraNode.position.y += 10 * joystick.yValue
        
        scrollSceneNodes()
    }
    
    func scrollSceneNodes() {
        for background in backgrounds {
            let x = background.position.x - cameraNode.position.x
            let y = background.position.y - cameraNode.position.y
            
            if x < -size.width {
                background.position.x += size.width * 2
            } else if x > size.width {
                background.position.x -= size.width * 2
            }
            
            if y < -size.height {
                background.position.y += size.height * 2
            } else if y > size.height {
                background.position.y -= size.height * 2
            }
        }
        
        
    }
}








