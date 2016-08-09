//
//  Joystick.swift
//  Joystick
//
//  Created by mitchell hudson on 7/20/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import Foundation
import SpriteKit


/*
 
 A simple touch Joystick. Appears at the location of a touch and follows your finger as you drag.
 
 The Joystick draws itself as two layers. A larger circle, the joystick, outlining the range of the Joystick,
 and a smaller circle that follows your finger, this is the stick. The stick is a child of joystick.
 
 */


class Joystick: SKNode {
    /** Container and background outline.  */
    let joystick: SKShapeNode
    /** Control element for the Joystick. */
    let stick: SKShapeNode
    
    /** The maximum range the stick can be dragged left, right, up, or down. */
    let maxRange:CGFloat = 50
    
    /** provides a value from -1 to +1 representing the horizontal stick position */
    var xValue: CGFloat = 0
    /** provides a value from -1 to +1 representing the vertical stick position */
    var yValue: CGFloat = 0
    
    
    
    
    /** Show the joystick on touchesBegan() at the position of a touch. */
    func show(touch: UITouch) {
        hidden = false
        position = touch.locationInNode(parent!)
    }
    
    /** Call this method on touchesMoved() the stick moves to the position of the touch. */
    func move(touch: UITouch) {
        let p = touch.locationInNode(self)
        let x = p.x.clamped(-maxRange, maxRange)
        let y = p.y.clamped(-maxRange, maxRange)
        
        stick.position = CGPoint(x: x, y: y)
        xValue = x / maxRange
        yValue = y / maxRange
    }
    
    /** Call this on touchesEnded() to hide the Joystick. */
    func hide() {
        hidden = true
        stick.position = CGPointZero
        xValue = 0
        yValue = 0
    }
    
    
    override init() {
        // Draw the joystick background.
        let joystickRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let joystickPath = UIBezierPath(ovalInRect: joystickRect)
        
        joystick = SKShapeNode(path: joystickPath.CGPath, centered: true)
        joystick.lineWidth = 2
        joystick.strokeColor = UIColor.whiteColor()
        joystick.fillColor = UIColor(white: 1, alpha: 0.5)
        
        // Draw the stick.
        let stickRect = CGRect(x: 0, y: 0, width: 40, height: 40)
        let stickPath = UIBezierPath(ovalInRect: stickRect)
        
        stick = SKShapeNode(path: stickPath.CGPath, centered: true)
        stick.lineWidth = 2
        stick.strokeColor = UIColor(white: 0.2, alpha: 1)
        stick.fillColor = UIColor(white: 0, alpha: 0.5)
        
        super.init()
        
        // Add add the joystick
        addChild(joystick)
        // Add the stick as a child of the joystick
        joystick.addChild(stick)
        // Hide this node
        hidden = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// Use this CGFloat extension to help generate values clamped to our desired range. 

extension CGFloat {
    /**
     Ensures that the float value stays between the given values, inclusive.
     */
    public func clamped(v1: CGFloat, _ v2: CGFloat) -> CGFloat {
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v2 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
    }
    
    /**
     Ensures that the float value stays between the given values, inclusive.
     */
    public mutating func clamp(v1: CGFloat, _ v2: CGFloat) -> CGFloat {
        self = clamped(v1, v2)
        return self
    }
}

