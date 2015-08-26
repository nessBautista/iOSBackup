//
//  CurveExample1.m
//  PathExamples
//
//  Created by Ness on 7/8/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "CurveExample1.h"

@implementation CurveExample1

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        self.backgroundColor=[UIColor blackColor];
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    CGContextRef context= UIGraphicsGetCurrentContext();
    
    /*Create a sine curve using 1 curve*/
    CGContextSaveGState(context);

    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.0f, 50.0f);
    CGContextAddCurveToPoint(context, 25.0f, 0.0f, 75.0f, 100.0f, 100.0f, 50.0f);
    [[UIColor greenColor]set];
    CGContextSetLineWidth(context, 5);
    CGContextStrokePath(context);  //Quartz clears the current path

    CGContextRestoreGState(context);
    
    /*Create a sine curve using 2 curves*/
    CGContextSaveGState(context);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.0f, 50.0f);
    CGContextAddCurveToPoint(context, 12.5f, 0.0f, 37.5f, 0.0f, 50.0f, 50.0f);
    CGContextAddCurveToPoint(context, 62.5f, 100.0f, 87.5f, 100.0f, 100.0f, 50.0f);
    [[UIColor orangeColor]set];
    CGContextSetLineWidth(context, 3);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
}


@end
