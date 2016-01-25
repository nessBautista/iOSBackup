//
//  canvas.swift
//  simpleFigures
//
//  Created by Ness on 12/30/15.
//  Copyright © 2015 Ness. All rights reserved.
//

import UIKit

class canvas: UIView {

    var counter = 0
    var adjustment:CGFloat = 0.8
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.backgroundColor! = UIColor.blackColor()
        
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        // Drawing code
        let currentContext = UIGraphicsGetCurrentContext();
        guard let context = currentContext  else{
            return
        }
        
        self.drawCentralCircle(context)

        
        self.drawViewAtPosition(0)
        self.drawViewAtPosition(1)
        self.drawViewAtPosition(2)
        self.drawViewAtPosition(3)
        self.drawViewAtPosition(4)
        self.drawViewAtPosition(5)
        self.drawViewAtPosition(6)
        self.drawViewAtPosition(7)
        self.drawViewAtPosition(8)
        self.drawViewAtPosition(9)
        
//        self.drawSatelliteAtPosition(context,position: 0)
//        self.drawSatelliteAtPosition(context,position: 2)
//        self.drawSatelliteAtPosition(context,position: 4)
//        self.drawSatelliteAtPosition(context,position: 6)
//        self.drawSatelliteAtAngle(context, angle: CGFloat(0))
//        self.drawSatelliteAtAngle(context, angle: CGFloat(45))
//        self.drawSatelliteAtAngle(context, angle: CGFloat(90))
//        self.drawSatelliteAtAngle(context, angle: CGFloat(135))
//        self.drawSatelliteAtAngle(context, angle: CGFloat(180))
//        self.drawSatelliteAtAngle(context, angle: CGFloat(225))
//        self.drawSatelliteAtAngle(context, angle: CGFloat(270))
//        self.drawSatelliteAtAngle(context, angle: CGFloat(315))
        
        //self.arrowDrawing(context)
        //self.roundUniverseClipping(context)
        //self.drawOneSimpleLine(context)
        //self.colorSquares(context)
        
        
//        /*When you draw arcs, Quartz draws a line between the current point
//        and the starting point of the arc*/
//        CGContextMoveToPoint(context, 0, 0);
//        CGContextAddArc(context, 50, 50, 25, CGFloat(M_PI), 2*CGFloat(M_1_PI), 1);
//        UIColor.blueColor().set()
//        CGContextSetLineWidth(context, 5);
//        CGContextStrokePath(context); //Quartz clears the current path
//        
        //[[UIColor purpleColor]set];
        //CGContextClosePath(context);
        
    }
    
    func drawCentralCircle(context:CGContextRef)
    {
        let R:CGFloat = self.frame.height/2
        CGContextSaveGState(context)
        CGContextSetLineWidth(context, 10)
        UIColor.blueColor().set()
        CGContextAddArc(context, self.frame.width/2, self.frame.height/2, R, 0.0,self.toRad(360), 1)
        CGContextStrokePath(context)
        CGContextRestoreGState(context)

    }
    
    func drawSatellite(context:CGContextRef)
    {
        CGContextSaveGState(context)
        CGContextSetLineWidth(context, 2)
        UIColor.orangeColor().set()
        let currentCenter = CGPointMake(self.frame.width/2, self.frame.height/2)
        let satelliteCenter = pointAtDegreeFromCenter(currentCenter, radius: self.frame.height/3, angle: 90.0)
        CGContextAddArc(context, satelliteCenter.x, satelliteCenter.y, 36, 0.0, self.toRad(360), 1)
        CGContextStrokePath(context)
        CGContextRestoreGState(context)
    }
    
    
    
    func drawSatelliteAtAngle(context:CGContextRef,angle:CGFloat)
    {
        CGContextSaveGState(context)
        CGContextSetLineWidth(context, 2)
        UIColor.orangeColor().set()
        let currentCenter = CGPointMake(self.frame.width/2, self.frame.height/2)
        let satelliteCenter = pointAtDegreeFromCenter(currentCenter, radius: self.frame.height/3, angle: angle)
        CGContextAddArc(context, satelliteCenter.x, satelliteCenter.y, self.getRadius(), 0.0, self.toRad(360), 1)
        CGContextStrokePath(context)
        CGContextRestoreGState(context)
    }
    
    func drawSatelliteAtPosition(context:CGContextRef,position:CGFloat)
    {
        CGContextSaveGState(context)
        CGContextSetLineWidth(context, 2)
        UIColor.orangeColor().set()
        let currentCenter = CGPointMake(self.frame.width/2, self.frame.height/2)
        let satelliteCenter = pointAtDegreeFromCenter(currentCenter, radius: self.frame.height/3, angle: position*self.dø(8))
        CGContextAddArc(context, satelliteCenter.x, satelliteCenter.y, self.getRadius(), 0.0, self.toRad(360), 1)
        CGContextStrokePath(context)
        CGContextRestoreGState(context)
    }
    
    
//////////////////
    func drawViewAtPosition(position:CGFloat)
    {
        let l:CGFloat = self.getRadius()*2.0
        let currentCenter = CGPointMake(self.frame.width/2, self.frame.height/2)
        let satelliteCenter = pointAtDegreeFromCenter(currentCenter, radius: self.frame.height/2, angle: position*self.dø(10))
        let r = getRadius()
        let drawingPoint = CGPointMake(satelliteCenter.x-r, satelliteCenter.y-r)
        let view = profileView(frame: CGRectMake(drawingPoint.x,drawingPoint.y,l,l))
        view.id = CGFloat(counter)
        counter += 1
        view.backgroundColor = UIColor.clearColor()
        self.addSubview(view)
    }
    func getRadius()->(CGFloat)
    {
        let dø = self.toRadCGFloat(self.dø(10))
        let r = (CGFloat(self.frame.height/3) * sin(dø))/2
        
        return r*adjustment
    }
    
//////////////////
    
    func toRad(degrees:Double)->(CGFloat)
    {
        let rads = (M_PI*degrees)/180
        return CGFloat(rads)
    }
    
    func toRadCGFloat(degrees:CGFloat)->(CGFloat)
    {
        let rads = (CGFloat(M_PI)*degrees)/180
        return CGFloat(rads)
    }
    func dø(parts:CGFloat)->(CGFloat)
    {
        return (360/parts)
    }
    
    //Point in circle using a center point reference and the radius of the circle
    func pointAtDegreeFromCenter(center:CGPoint, radius:CGFloat, angle:CGFloat)->(CGPoint)
    {
        let rads = self.toRad(Double(angle))
        let x = center.x + radius * cos(rads)
        let y = center.y - radius * sin(rads)
        return CGPointMake(x, y)
    }
    
    
    func colorSquares(context:CGContextRef)
    {
        //Get a square mask
        UIGraphicsBeginImageContext(self.bounds.size)
        let maskContext = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(maskContext, 0, self.frame.height)
        CGContextScaleCTM(maskContext, 1.0, -1.0)
        CGContextFillRect(maskContext, CGRectMake(0, 50, 100, 100))
        let mask = CGBitmapContextCreateImage(maskContext)
        UIGraphicsEndImageContext()
        
        //Now clip the recent created mask
        CGContextSaveGState(context)
        CGContextClipToMask(context, self.frame, mask)
        let colorSquares = UIImage(named: "ColorSquares")?.CGImage
        CGContextDrawImage(context, self.frame, colorSquares)
        CGContextRestoreGState(context)
        
        //Draw the border
        CGContextSaveGState(context)
        CGContextSetLineWidth(context, 10.0)
        UIColor.orangeColor().set()
        CGContextStrokeRect(context, CGRectMake(0, 50, 100, 100))
        CGContextRestoreGState(context)
    }
    func drawOneSimpleLine(context:CGContextRef)
    {
        /*
            UIView uses an inverted coordinate system. This causes the line is drawn like this: \
            In order to use the default Quartz Coordinate system (normal) you need to do an inversion of the Current Transform Matix
        */
        
        //Draws a blue line in inverted Coordinate System
        CGContextSaveGState(context)
            CGContextSetLineWidth(context, 10)
            UIColor.blueColor().set()
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, 0, 0)
            CGContextAddLineToPoint(context, self.frame.width, self.frame.height)
            CGContextStrokePath(context)
        CGContextRestoreGState(context)
        
        //Draws a orange line in the normal coordinate system (this is how quartz looks like)
        CGContextSaveGState(context)
            //Invert context by applying a transform that translate the origin to the upper left corner
            //and scales the y coordinate by -1
            CGContextTranslateCTM(context, 0, self.frame.height)
            CGContextScaleCTM(context, 1.0, -1.0)
            UIColor.orangeColor().set()
            CGContextSetLineWidth(context, 10)
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, 0, 0)
            CGContextAddLineToPoint(context, self.frame.width, self.frame.height)
            CGContextStrokePath(context)
        CGContextRestoreGState(context)
        
    }
    
    func roundUniverseClipping(context:CGContextRef)
    {
        /*
            In this function a circular mask is created to be clipped into a widder pictur.
            As a result we have a circular window that allow us to see a circular section of the universe
        */
        //Create a circular mask
        
        UIGraphicsBeginImageContext(self.frame.size)
            let maskContext = UIGraphicsGetCurrentContext()
            CGContextTranslateCTM(maskContext, 0, self.frame.height)
            CGContextScaleCTM(maskContext, 1.0, -1.0)
            CGContextFillEllipseInRect(maskContext, CGRectMake(self.frame.width/2, self.frame.height/2, 100, 100))
            let mask = CGBitmapContextCreateImage(maskContext)
        UIGraphicsEndImageContext()
        
        //Save context before clipping
        CGContextSaveGState(context)
            CGContextClipToMask(context, self.bounds, mask)
            let universe = UIImage(named: "universe")?.CGImage
            //universe!.drawAtPoint(CGPointMake(-500, 0))
            CGContextDrawImage(context, self.frame, universe)
        CGContextRestoreGState(context)
        
        
        //Draw yellow line
        CGContextSaveGState(context)
            UIColor.orangeColor().set()
            CGContextSetLineWidth(context, 5)
            CGContextSetLineCap(context, CGLineCap.Round)
            CGContextStrokeEllipseInRect(context, CGRectMake(self.frame.width/2, self.frame.height/2, 100, 100))
        CGContextRestoreGState(context)
    }
    
    func circleDrawing(context:CGContextRef)
    {
        CGContextSaveGState(context)
        CGContextBeginPath(context)
        CGContextAddArc(context, 200, 200, 70, 0, CGFloat(Float(M_PI) * 2.0), 1)
        UIColor.greenColor().set()
        CGContextSetLineWidth(context, 2)
        CGContextStrokePath(context);  //Quartz clears the current path
        CGContextRestoreGState(context);

    }
    func arrowDrawing(context: CGContextRef)
    {

        CGContextSaveGState(context)
        
        //punch triangular hole in context clipping region
        CGContextMoveToPoint(context, 90, 100)
        CGContextAddLineToPoint(context, 100, 90)
        CGContextAddLineToPoint(context, 110, 100)
        CGContextClosePath(context)
        CGContextAddRect(context, CGContextGetClipBoundingBox(context))
        CGContextEOClip(context)
        //draw the vertical line, add its shape to the clipping region
        CGContextMoveToPoint(context, 100, 100)
        CGContextAddLineToPoint(context, 100, 19)
        CGContextSetLineWidth(context, 20)
        CGContextReplacePathWithStrokedPath(context)
        CGContextClip(context)
        //Draw the gradient
        let locs:[CGFloat] = [0.0,0.5,1.0]
        let colors:[CGFloat] = [0.3,0.3,0.3,0.8,
                                0.0,0.0,0.0,1.0,
                                0.3,0.3,0.3,0.8]
        
        let sp = CGColorSpaceCreateDeviceGray()
        let grad = CGGradientCreateWithColorComponents(sp, colors, locs, 3)
        CGContextDrawLinearGradient(context, grad, CGPointMake(89, 0), CGPointMake(111, 0), CGGradientDrawingOptions.DrawsAfterEndLocation)
        CGContextRestoreGState(context) //Done clipping
        
        //draw the red trinagle, the point of the arrow
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextMoveToPoint(context, 80, 25)
        CGContextAddLineToPoint(context, 100, 0)
        CGContextAddLineToPoint(context, 120, 25)
        CGContextFillPath(context)
    }


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
}
