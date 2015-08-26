//
//  myLayer.m
//  DrawingOnLayers
//
//  Created by Ness on 7/29/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "myLayer.h"
#import "mySublayer.h"
@interface myLayer(){
    //You can have CALayers to be used along in the hierarchy
    CALayer *arrow; //we have one in this case
    mySublayer *msl;
    BOOL orange;
}
@end

@implementation myLayer


/*
        DRAWING AS A CALAYER SUBCLASS
    You can draw on a layer subclass by using this 2 methods
 */

-(void)display{
    //This changes only the image contents
    NSLog(@"display from myLayer subclass");
    self.backgroundColor=[UIColor purpleColor].CGColor;
}

//-(void)drawInContext:(CGContextRef)context{
//    /*  This method draws the content of the UNDERLAYING LAYER of our UIVIEW subclass
//        and if it's working is because we have choose to use the subclass method instead
//        of the delegate methods. Both are triggered by a setNeedsDisplay in the view which
//        contains the layers.
//     
//     */
//    
//    
//    //This draws directly in the layer (programmatically)
//    NSLog(@"drawInContext: from myLayer subclass");
//    
//        // Example of gradient drawing
//        CGContextSaveGState(context);
//    
//        CGFloat locs[5]={0.0,0.25,0.256,0.5,1.0};
//        CGFloat colors[20]={
//            0.11,0.49,0.97,0.8,       //blue
//            0.49,0.82,0.73,0.3,       //green
//            1.0,1.0,1.0,0.9,          //white
//            0.75,0.29,0.85,0.3,       //purple
//            0.85,0.52,0.14,0.8        //Orange
//        };
//    
//        CGColorSpaceRef sp= CGColorSpaceCreateDeviceRGB();
//        CGGradientRef grad= CGGradientCreateWithColorComponents(sp, colors, locs, 5);
//        CGContextDrawLinearGradient(context, grad, CGPointMake(100.0, 0.0), CGPointMake(0, 100), 0);
//    
//        CGColorSpaceRelease(sp);
//        CGGradientRelease(grad);
//        CGContextRestoreGState(context);
//    
//    /*
//     We have choose this subclass (myLayer subclass) as delegate for the arrow CALayer subclass
//     thus we can overide the response method to update this layer. 
//     
//     Seems convinient to use this delegate methods as we can update all the layers contained in the view
//     in this moment. Suppose we have 3 sublayers below this underlaying layer, we will use:
//     
//     [self drawLayer:sublayer1 inContext:context];
//     [self drawLayer:sublayer2 inContext:context];
//     [self drawLayer:sublayer3 inContext:context];
//     
//     */
//    [self drawLayer:arrow inContext:context];
//    [msl drawInContext:context];
//}

- (void) layoutSublayers {
    /*This method is called at the begining, we use it for setup*/
    NSLog(@"calling the layout sublayers");
    [self setup];
}

-(void)setup{
    NSLog(@"Making myLayer class the delegate of the arrow class");    
    
    ////--- Start by creating a CALayer subclass and fix the bounds, position and DELEGATE
    arrow = [CALayer new];
    arrow.bounds = self.bounds;
    arrow.position = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds));
    arrow.delegate = self;
    
    ////--- Add this sublayer
    [self addSublayer:arrow];
    orange=YES;
    
    
    ////--- Add your own sublayer class
    msl = [mySublayer new];
    msl.bounds=self.bounds;
    msl.position=CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds));
    msl.delegate=self;
    
    ////---Add this sublayer
    [self addSublayer:msl];
    /***You can use setNeedsDisplay to call the delegate methods in order to do the first drawn
        In this case we have choosen the method drawLayer:inContext, which is overiden below
     ***/
    

    /****Need to check why **/
    //[arrow setNeedsDisplay];
    //[msl setNeedsDisplay];
    
    /****When drawRect is not defined in the UIView class*/
    [self display];
}

/*
        DELEGATE METHOD
    This CALayer subclass is the delegate of a CALayer subclass named arrow.
    You have two options when this arrow class needs to be displayed:

    Change contents of image:
    -(void)displayLayer:(CALayer *)layer
 
    Draw using core graphic functions
    -(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context

 
 
 */

//Responds to drawing needs of the arrow subclass
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"drawLayerIncOntext for the arrow Layer subclass");
    
    //Drawing an Orange/Green circle as added sublayer
    if(orange){
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
        CGContextBeginPath(ctx);
        CGContextAddEllipseInRect(ctx, CGRectInset(self.bounds, 10, 10));
        CGContextFillPath(ctx);
        CGContextRestoreGState(ctx);
        orange=NO;
    }else{
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
        CGContextBeginPath(ctx);
        CGContextAddEllipseInRect(ctx, CGRectInset(self.bounds, 10, 10));
        CGContextFillPath(ctx);
        CGContextRestoreGState(ctx);
        orange=YES;

    }
    
}

@end
