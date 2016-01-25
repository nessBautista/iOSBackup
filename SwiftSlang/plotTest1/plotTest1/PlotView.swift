//
//  PlotView.swift
//  plotTest1
//
//  Created by Ness on 1/8/16.
//  Copyright © 2016 Ness. All rights reserved.
//

import UIKit


class PlotView: UIView {

    // MARK: Geometric Constants
    var kGraphHeight = 300
    var kDefaultGraphWidth = 600
    var kOffsetX = 10
    var kStepX = 50
    var kGraphBottom = 300
    var kGraphTop = 0
    
    
    
    // MARK: Init routines
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
    }
    
    
    

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSaveGState(context)
        CGContextSetLineWidth(context, 10.0)
        CGContextSetStrokeColorWithColor(context, UIColor.greenColor().CGColor)
        CGContextMoveToPoint(context, 0.0, 0.0)
        CGContextAddLineToPoint(context, self.frame.width/2, self.frame.height/2)
        
//        let howMany = (kDefaultGraphWidth - kOffsetX) / kStepX
//
//        for i in 0...howMany
//        {
//            CGContextMoveToPoint(context, CGFloat(kOffsetX) + CGFloat(i*kStepX), CGFloat(kGraphTop))
//            CGContextAddLineToPoint(context, CGFloat(kOffsetX) + CGFloat(i * kStepX), CGFloat(kGraphBottom))
//        }
        
        CGContextStrokePath(context)
        
        CGContextRestoreGState(context)
    }


}
