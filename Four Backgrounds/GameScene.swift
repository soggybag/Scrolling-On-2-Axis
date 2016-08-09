//
//  GameScene.swift
//  Four Backgrounds
//
//  Created by mitchell hudson on 8/8/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var backgrounds = [SKSpriteNode]()
    let cameraNode: SKCameraNode
    let joystick = Joystick()
    
    override init(size: CGSize) {
        print("??????")
        for i in 0 ..< 4 {
            let hue = CGFloat(arc4random() % 1000) / 1000
            let background = SKSpriteNode(color: UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1), size: size)
            background.position.x = CGFloat(i % 2) * size.width
            background.position.y = CGFloat(i / 2) * size.height
            
            background.anchorPoint = CGPointZero
            
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
            print(background)
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
            
            if x < -(size.width + view!.frame.width / 2) {
                background.position.x += size.width * 2
            } else if x > size.width + view!.frame.width / 2 {
                background.position.x -= size.width * 2
            }
            
            if y < -(size.height + view!.frame.height / 2) {
                background.position.y += size.height * 2
            } else if y > size.height + view!.frame.height / 2 {
                background.position.y -= size.height * 2
            }
        }
    }
}








