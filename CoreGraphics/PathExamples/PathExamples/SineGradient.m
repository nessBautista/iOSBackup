//
//  LineGradient.m
//  PathExamples
//
//  Created by Ness on 7/10/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "SineGradient.h"

@implementation SineGradient

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        self.backgroundColor=[UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //Get current context to work with Quartz functions
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Draw Routine
    CGContextSaveGState(context);
    //Draw a sine line
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.0f, 50.0f);
    CGContextAddCurveToPoint(context, 12.5f, 0.0f, 37.5f, 0.0f, 50.0f, 50.0f);
    CGContextAddCurveToPoint(context, 62.5f, 100.0f, 87.5f, 100.0f, 100.0f, 50.0f);
    CGContextSetLineWidth(context, 10);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextReplacePathWithStrokedPath(context);

    //Doesn't work
    //CGContextFillPath(context);
    //CGContextStrokePath(context);
    //CGContextDrawPath(context, kCGPathStroke);
    
    //Clip the line you just draw
    CGContextClip(context);
    
    //Create a gradient to fill the space whithin the line
    //Gradient locations and colors
    CGFloat locs[4]={0.0,0.25,0.5,1.0};
    
    CGFloat colors[16]={
        0.11,0.49,0.97,0.8,       //blue
        0.49,0.82,0.73,1.0,       //green
        0.75,0.29,0.85,1.0,       //purple
        0.85,0.52,0.14,8.0        //Orange
    };
    
    CGColorSpaceRef sp=CGColorSpaceCreateDeviceRGB();
    CGGradientRef grad = CGGradientCreateWithColorComponents(sp, colors, locs, 4);
    CGContextDrawLinearGradient(context, grad, CGPointMake(100.0, 0.0), CGPointMake(0, 100), 0);
    CGColorSpaceRelease(sp);
    CGGradientRelease(grad);
    
    
    CGContextRestoreGState(context);    //DONE CLIPPING

    
    
    
    
    
}


@end
