//
//  GradientExample1.m
//  PathExamples
//
//  Created by Ness on 7/10/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "GradientExample1.h"

@implementation GradientExample1
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        self.backgroundColor=[UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context= UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGFloat locs[5]={0.0,0.25,0.256,0.5,1.0};
    CGFloat colors[20]={
      0.11,0.49,0.97,0.8,       //blue
      0.49,0.82,0.73,0.3,       //green
      1.0,1.0,1.0,0.9,          //white
      0.75,0.29,0.85,0.3,       //purple
      0.85,0.52,0.14,0.8        //Orange
    };
    
    CGColorSpaceRef sp= CGColorSpaceCreateDeviceRGB();
    CGGradientRef grad= CGGradientCreateWithColorComponents(sp, colors, locs, 5);
    CGContextDrawLinearGradient(context, grad, CGPointMake(100.0, 0.0), CGPointMake(0, 100), 0);
    
    
    CGColorSpaceRelease(sp);
    CGGradientRelease(grad);
    CGContextRestoreGState(context);

}


@end
