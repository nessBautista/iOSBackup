//
//  ArcExample1.m
//  PathExamples
//
//  Created by Ness on 7/8/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "ArcExample1.h"

@implementation ArcExample1

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
    
    
    CGContextBeginPath(context);
    //CGContextMoveToPoint(context, 0, 0);
    CGContextAddArc(context, 50, 50, 25, 0, M_PI, 1);
    [[UIColor greenColor]set];
    CGContextSetLineWidth(context, 5);
    CGContextStrokePath(context);  //Quartz clears the current path
    CGContextClosePath(context);
    
    /*When you draw arcs, Quartz draws a line between the current point 
     and the starting point of the arc*/
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddArc(context, 50, 50, 25, M_PI, 2*M_PI, 1);
    [[UIColor blueColor]set];
    CGContextSetLineWidth(context, 5);
    CGContextStrokePath(context); //Quartz clears the current path
    
    //[[UIColor purpleColor]set];
    //CGContextClosePath(context);

    
    
    CGContextRestoreGState(context);
    
}


@end
