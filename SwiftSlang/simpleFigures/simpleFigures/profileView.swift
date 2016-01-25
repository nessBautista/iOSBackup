//
//  profileView.swift
//  simpleFigures
//
//  Created by Ness on 1/24/16.
//  Copyright © 2016 Ness. All rights reserved.
//

import UIKit

class profileView: UIView {

    var id:CGFloat!
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let currentContext = UIGraphicsGetCurrentContext();
        guard let context = currentContext  else{
            return
        }
        
        //self.drawCentralCircle(context)
        self.backgroundColor = UIColor.clearColor()
        //self.drawImage(context)
        self.roundUniverseClipping(context)
        //self.drawCentralCircle(context)
    }

    func drawImage(context:CGContextRef)
    {
        CGContextSaveGState(context)
        let img = UIImage(named: "ColorSquares")?.CGImage
        //let img = getClippedImage()
        CGContextDrawImage(context, CGRectInset(self.bounds, 1, 1), img)
        CGContextRestoreGState(context)
    }
    
    func getClippedImage()->(CGImageRef)
    {
        UIGraphicsBeginImageContext(self.bounds.size)
        let maskContext = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(maskContext, 0, self.bounds.height)
        CGContextScaleCTM(maskContext, 1.0, -1.0)
        CGContextFillEllipseInRect(maskContext, CGRectInset(self.bounds, 0, 0))
        let mask = CGBitmapContextCreateImage(maskContext)
        UIGraphicsEndImageContext()
        

        UIGraphicsBeginImageContext(self.bounds.size)
        let clippedContext = UIGraphicsGetCurrentContext()
        CGContextSaveGState(clippedContext)
        CGContextClipToMask(clippedContext, self.bounds, mask)
        let universe = UIImage(named: "ColorSquares")?.CGImage
        CGContextDrawImage(clippedContext, CGRectInset(self.bounds, 1, 1), universe)
        CGContextRestoreGState(clippedContext)
        
        
        CGContextSaveGState(clippedContext)
        UIColor.orangeColor().set()
        CGContextSetLineWidth(clippedContext, 2)
        CGContextSetLineCap(clippedContext, CGLineCap.Round)
        CGContextStrokeEllipseInRect(clippedContext, self.bounds)
        CGContextRestoreGState(clippedContext)
        
        let result = CGBitmapContextCreateImage(clippedContext)

        return result!
    }
    
    func drawCentralCircle(context:CGContextRef)
    {
        //let R:CGFloat = self.bounds.height/3
        CGContextSaveGState(context)
        CGContextSetLineWidth(context, 2.5)
        UIColor.orangeColor().set()
        //CGContextAddArc(context, self.bounds.width/2, self.bounds.height/2, R, 0.0,self.toRad(360), 1)
        CGContextFillEllipseInRect(context, self.bounds)
        CGContextStrokePath(context)
        CGContextRestoreGState(context)

    }
    
    func toRad(degrees:Double)->(CGFloat)
    {
        let rads = (M_PI*degrees)/180
        return CGFloat(rads)
    }
    
    func roundUniverseClipping(context:CGContextRef)
    {
        /*
        In this function a circular mask is created to be clipped into a widder pictur.
        As a result we have a circular window that allow us to see a circular section of the universe
        */
        //Create a circular mask
        
        UIGraphicsBeginImageContext(self.bounds.size)
        let maskContext = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(maskContext, 0, self.bounds.height)
        CGContextScaleCTM(maskContext, 1.0, -1.0)
        CGContextFillEllipseInRect(maskContext, CGRectInset(self.bounds, 0, 0))
        let mask = CGBitmapContextCreateImage(maskContext)
        UIGraphicsEndImageContext()
        
        //Save context before clipping
        CGContextSaveGState(context)
        CGContextClipToMask(context, self.bounds, mask)
        let universe = UIImage(named: "universe")?.CGImage
        //universe!.drawAtPoint(CGPointMake(-500, 0))
        CGContextDrawImage(context, CGRectInset(self.bounds, 1, 1), universe)
        CGContextRestoreGState(context)
        
        
        //Draw yellow line
        CGContextSaveGState(context)
        UIColor.orangeColor().set()
        CGContextSetLineWidth(context, 2)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextStrokeEllipseInRect(context, self.bounds)
        CGContextRestoreGState(context)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(self.id)
    }
}


