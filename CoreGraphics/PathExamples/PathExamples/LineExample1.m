//
//  LineExample1.m
//  PathExamples
//
//  Created by Ness on 7/8/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "LineExample1.h"

@implementation LineExample1

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        self.backgroundColor=[UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
////--->Initial settings: Get context and save the default graphic state
    
    //Get the current context
    CGContextRef context=UIGraphicsGetCurrentContext();
    //You are about to modify the grahpic state, remember you need to save and then restore
    CGContextSaveGState(context);
    
    ////--->Path drawing settings: color, stroke type...
    
    //Set width
    CGContextSetLineWidth(context, 1);
    //Set line cap
    CGContextSetLineCap(context, kCGLineCapRound);
    //set dash patern
    CGFloat dash[]={2,3};
    CGContextSetLineDash(context, 0, dash, 1);
    //Set color
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    ////--->Path construction
    
    //Begin a new path
    CGContextBeginPath(context);
    //Set the first point of the path
    CGContextMoveToPoint(context, 10, 10);
    //Draw a simple line crossing through the view
    CGContextAddLineToPoint(context, self.bounds.size.width-10, self.bounds.size.height-10);
    
    ////--->Path Rendering
    CGContextStrokePath(context);

////--->Restore to the default graphic state
    CGContextRestoreGState(context);

    

    
}


@end
