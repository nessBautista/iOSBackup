//
//  SolarSystem.swift
//  simpleFigures
//
//  Created by Ness on 1/24/16.
//  Copyright © 2016 Ness. All rights reserved.
//

import UIKit

class SolarSystem: UIView
{

    //MARK: Data Structs
    struct Orbit
    {
        let radius:CGFloat
        let nodes:CGFloat
        let dø:CGFloat          /*Angular differencial*/
    }
    
    //MARK: Properties and outlets
    //Geometry 
    var R:CGFloat!              /*Max Radius possible for present view*/
    var C:CGPoint!              /*Center of the view*/
    var H:CGFloat!              /*Present View height*/
    var W:CGFloat!              /*Present View widht*/
    var numberOfNodes:[CGFloat]!    /*Satellites in orbit*/
    var Orbits:[Orbit]!
    var dø:[CGFloat]!
    var adjustment:CGFloat!
    //MARK: LIFE CYCLE
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.backgroundColor! = UIColor.blackColor()

    }
    
    //MARK: Drawing Functions
    override func drawRect(rect: CGRect)
    {

        
         self.loadConfig()
        

        self.drawSatellitesInOrbit(0, atPosition: 0)
        self.drawSatellitesInOrbit(0, atPosition: 1)
        self.drawSatellitesInOrbit(0, atPosition: 2)
        self.drawSatellitesInOrbit(0, atPosition: 3)
        self.drawSatellitesInOrbit(0, atPosition: 4)
        self.drawSatellitesInOrbit(0, atPosition: 5)
        self.drawSatellitesInOrbit(0, atPosition: 6)
        self.drawSatellitesInOrbit(0, atPosition: 7)
        
        self.drawSatellitesInOrbit(1, atPosition: 0)
        self.drawSatellitesInOrbit(1, atPosition: 1)
        self.drawSatellitesInOrbit(1, atPosition: 2)
        self.drawSatellitesInOrbit(1, atPosition: 3)
        self.drawSatellitesInOrbit(1, atPosition: 4)
        self.drawSatellitesInOrbit(1, atPosition: 5)
        self.drawSatellitesInOrbit(1, atPosition: 6)
        self.drawSatellitesInOrbit(1, atPosition: 7)
  
        
        self.drawSatellitesInOrbit(2, atPosition: 0)
        self.drawSatellitesInOrbit(2, atPosition: 1)
        self.drawSatellitesInOrbit(2, atPosition: 2)
        self.drawSatellitesInOrbit(2, atPosition: 3)
        self.drawSatellitesInOrbit(2, atPosition: 4)



        let currentContext = UIGraphicsGetCurrentContext()
        guard let context = currentContext  else{
            return
        }
        
       
        self.drawOrbits(context)
        self.drawCenter(context)
        
        
    }

    //MARK: Load Config
    func loadConfig()
    {
        //Get global geometry references
        
        self.W = self.frame.width
        self.H = self.frame.height
        self.C = CGPointMake(W/2, H/2)
        self.R = H >= W ? W/2 : H/2
        self.adjustment = 0.80
        //Construct orbit information
        
        if let numberOfNodesInOrbit = self.numberOfNodes{
//            self.dø = [CGFloat(360)/CGFloat(numberOfNodesInOrbit[0]),
//                CGFloat(360)/CGFloat(numberOfNodesInOrbit[1]),
//                CGFloat(360)/CGFloat(numberOfNodesInOrbit[2])]
            
            let Orbit1 = Orbit(radius: R*0.27, nodes: numberOfNodesInOrbit[0], dø: CGFloat(360)/CGFloat(numberOfNodesInOrbit[0]))
            
            let Orbit2 = Orbit(radius: R*0.57, nodes: numberOfNodesInOrbit[1], dø: CGFloat(360)/CGFloat(numberOfNodesInOrbit[1]))
            
            let Orbit3 = Orbit(radius: R*0.90, nodes: numberOfNodesInOrbit[2], dø: CGFloat(360)/CGFloat(numberOfNodesInOrbit[2]))
            
            self.Orbits = [Orbit1,Orbit2,Orbit3]
        }
        else
        {
            self.dø = [CGFloat]()
        }
        
    }

    func drawOrbits(context:CGContextRef)
    {
        CGContextSaveGState(context)
        CGContextSetLineWidth(context, 10)
        UIColor.blueColor().set()
        CGContextAddArc(context, self.C.x, self.C.y, self.Orbits[0].radius, 0.0, self.toRad(360), 1)
        CGContextStrokePath(context)
        CGContextAddArc(context, self.C.x, self.C.y, self.Orbits[1].radius, 0.0, self.toRad(360), 1)
        CGContextStrokePath(context)
        CGContextAddArc(context, self.C.x, self.C.y, self.Orbits[2].radius, 0.0, self.toRad(360), 1)
        CGContextStrokePath(context)
        CGContextRestoreGState(context)

    }
    
    func drawSatellitesInOrbit(orbit:Int, atPosition position:CGFloat)
    {

        let satelliteCenter = self.getPointAtCircunferenceOf(radius: Orbits[orbit].radius, WithCenter: self.C, AtAngle: Orbits[orbit].dø*position)
        
        let r = self.getSatelliteRadiusInOrbit(orbit)
        let drawingPoint = CGPointMake(satelliteCenter.x-r, satelliteCenter.y-r)
        let l:CGFloat = r*2
        let view = profileView(frame: CGRectMake(drawingPoint.x,drawingPoint.y,l,l))
        view.id = position
        view.backgroundColor = UIColor.clearColor()
        self.addSubview(view)
        
    }
    
    func drawCenter(context:CGContextRef)
    {
        CGContextSaveGState(context)
        CGContextSetLineWidth(context, 10)
        UIColor.greenColor().set()
        CGContextMoveToPoint(context, self.bounds.width/2, 0)
        CGContextAddLineToPoint(context, self.bounds.width/2, self.bounds.height)
        CGContextStrokePath(context)

        CGContextMoveToPoint(context, 0, self.bounds.height/2)
        CGContextAddLineToPoint(context, self.bounds.width, self.bounds.height/2)
        CGContextStrokePath(context)
        
        CGContextRestoreGState(context)
    }
    
    
    //MARK: Geometry stuff
    //Point in circle using a center point reference and the radius of the circle
    func getPointAtCircunferenceOf(radius radius:CGFloat, WithCenter center:CGPoint, AtAngle angle:CGFloat)->(CGPoint)
    {
        let rads = self.toRad(Double(angle))
        let x = center.x + radius * cos(rads)
        let y = center.y - radius * sin(rads)   /* (+ or -) according with coordinate system */
        return CGPointMake(x, y)
    }
    
    func getSatelliteRadiusInOrbit(OrbitNumber:Int)->(CGFloat)
    {
        /***********/
        //Adjustable size
        var r = ((self.Orbits[OrbitNumber].radius) * sin(self.Orbits[OrbitNumber].dø))/2
        //Fixed size
        //var r = ((self.Orbits[0].radius) * sin(self.Orbits[0].dø))/2
        if r < 0
        {
            r *= -1     //remember that for angles +180 values are negative
        }
        return r*adjustment
        /***********/
    }
    
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
    

}
