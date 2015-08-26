//
//  RadialGradient.m
//  PathExamples
//
//  Created by Ness on 8/6/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "RadialGradient.h"

@implementation RadialGradient
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor=[UIColor blackColor];
        H=self.bounds.size.height;
        W=self.bounds.size.width;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //Create a circular mask
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef maskContext = UIGraphicsGetCurrentContext();
    CGContextFillEllipseInRect(maskContext, CGRectInset(self.bounds, 10, 10));
    CGImageRef mask= CGBitmapContextCreateImage(maskContext);
    CGContextClipToMask(context, self.bounds, mask);
    CGImageRelease(mask);
    UIGraphicsEndImageContext();
    
    //Now draw a gradient
    
    CGContextSaveGState(context);
    
    CGFloat loc[3]={0.1,0.2,0.3};
    CGFloat colors[12]={
                121/255.0,  126/255.0,   16/255.0,   1.0,//yellow
               61/255.0,  255/255.0,  0,   1.0,         //green
               236/255.0, 171/255.0,  233/255.0,   1.0  //pink
            };
    CGColorSpaceRef colorspace=CGColorSpaceCreateDeviceRGB();
    CGGradientRef grad=CGGradientCreateWithColorComponents(colorspace, colors, loc, 3);
    //CGContextDrawLinearGradient(context, grad, CGPointMake(0, 0), CGPointMake(self.bounds.size.width, self.bounds.size.height), 0);
    CGContextDrawRadialGradient(context, grad, CGPointMake(W/2, H/2), 2, CGPointMake(W/2, H/2), W, kCGGradientDrawsBeforeStartLocation);
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(grad);
    CGContextRestoreGState(context);
}


@end
