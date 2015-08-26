//
//  LineExample2.m
//  PathExamples
//
//  Created by Ness on 7/8/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "LineExample2.h"

@implementation LineExample2

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        self.backgroundColor=[UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
////--->Initial settings
    //get current context
    CGContextRef context=UIGraphicsGetCurrentContext();
    //save the current graphic state before any alteration
    CGContextSaveGState(context);
    
    ////--->Draw a new path
    
    //Create a new path
    CGContextBeginPath(context);
    
    ////---> draw first line (first subpath)
    
    //Set the starting point
    CGContextMoveToPoint(context, 5, 5);
    //Draw line
    CGContextAddLineToPoint(context, self.bounds.size.width-5, 5);
    //Close subpath
    CGContextClosePath(context);
    //set color and width
    [[UIColor blueColor]set];
    CGContextSetLineWidth(context, 5);
    ////--->Render the path
    CGContextStrokePath(context);
    
    ////---> draw second line (second subpath)
    
    //Set starting point of the second subpath
    CGContextMoveToPoint(context, self.bounds.size.width-5, 10);
    //draw line
    CGContextAddLineToPoint(context, self.bounds.size.width-5, self.bounds.size.height-5);
    //Set color and widht
    [[UIColor orangeColor]set];
    CGContextSetLineWidth(context, 2);
    ////--->Render the path
    CGContextStrokePath(context);
    
////--->Final steps previous continues drawings: Restore graphic state
    CGContextRestoreGState(context);

    
}


@end
