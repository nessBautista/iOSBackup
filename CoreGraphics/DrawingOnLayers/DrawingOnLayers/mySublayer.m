//
//  mySublayer.m
//  DrawingOnLayers
//
//  Created by Ness on 7/29/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "mySublayer.h"
@interface mySublayer(){
    BOOL red;
}

@end
@implementation mySublayer

-(void)drawInContext:(CGContextRef)ctx{
    NSLog(@"drawInContext from SUBLAYER");
    if (red) {
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
        CGContextBeginPath(ctx);
        CGContextAddRect(ctx, CGRectInset(self.bounds, 30, 30));
        CGContextFillPath(ctx);
        CGContextRestoreGState(ctx);
        red=NO;
    }else{
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
        CGContextBeginPath(ctx);
        CGContextAddRect(ctx, CGRectInset(self.bounds, 30, 30));
        CGContextFillPath(ctx);
        CGContextRestoreGState(ctx);
        red=YES;
    }


}

- (void) layoutSublayers {
    red=YES;
}
@end
