//
//  TriangleGradientWave.m
//  PathExamples
//
//  Created by Ness on 7/10/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "TriangleGradientWave.h"

@implementation TriangleGradientWave

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        self.backgroundColor=[UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //get current context
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //Drawing routines
    CGContextSaveGState(context);
    
    //Draw a triangular shape
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 75);
    CGContextAddLineToPoint(context, 25, 10);
    CGContextAddLineToPoint(context, 50, 75);
    CGContextAddLineToPoint(context, 75, 9);
    CGContextAddLineToPoint(context, 100, 75);
    CGContextSetLineWidth(context, 5);
    CGContextReplacePathWithStrokedPath(context);
    CGContextClip(context);
    
    //Draw gradient
    
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
