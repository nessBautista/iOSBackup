//
//  myView.m
//  DrawingOnLayers
//
//  Created by Ness on 7/29/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "myView.h"
#import "myLayer.h"
@implementation myView
/*
    -A view draws on its underlaying layer if drawRect: is implemented
    -The VIEW is the DELEGATE of its underlaying layer
 */



//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    NSLog(@"drawRect: from myView");
//    /*
//     
//     This method is not called when weather drawInContext: or display: method is used
//     Because what drawRect does is draw into the layer, which is exactly what
//     drawInContext: is used for.
//     
//     */
//}


/*
 If you subclass UIView and you want your subclass's underlaying layer
 be an instance of a CALayer subclass, you need to implement the UIView 
 subclass's layerClass class method to return that CALayer subclass
 */

+(Class)layerClass{
    /*
     When this UIView subclass is instantiated, its underalying layer
     will be our subclass implementation of CALayer: myLayer
     */
    return  [myLayer class];
}


/*
                        DRAWING AS A DELEGATE
    So this view is the delegate of it's underlaying layer. This class have the
    responsability to respond to calls from its delegate object [layer setNeedDisplay]
    with the method drawLayer:inContext.
 
    So it can draw to its layer by using 2 methods (choose only one)
    Apparently these methods are not very common is not a good idea
    to call them from the delegate as this can causes problems.
 
 */

//-(void)displayLayer:(CALayer *)layer{
//    NSLog(@"displayLayer from myView");
//    self.layer.backgroundColor=[UIColor redColor].CGColor;
//    /*
//     
//     This method doesn't have a graphic context, so you will be limited
//     to change the contents image
//     
//     */
//}


//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context{
//    NSLog(@"drawLayer:inContext from MyView");
//    self.backgroundColor=[UIColor blueColor];
//    /*
//     This method is called by the drawRect: method as part of the process of
//     drawing.
//     
//     This method will be called when the layer receives de message to redisplay
//     itself. Normally a call comming from its view delegate The process is:
//     
//     -->CALayer subclass receives message to redisplay via 
//        its delegate (our subview class):setNeedDisplay or setNeedDisplay:inRect.
//     
//     -->The delegate (in this case this UIView subclass) use the
//        drawLayer:inContext method to use core graphics functions to draw
//     
//     
//     With this you can draw directly on the layer using the graphic context,
//     which by the way, you still need to make it the current context.
//     */
//    
//    
//    // Example of gradient drawing
//    CGContextSaveGState(context);
//    
//    CGFloat locs[5]={0.0,0.25,0.256,0.5,1.0};
//    CGFloat colors[20]={
//        0.11,0.49,0.97,0.8,       //blue
//        0.49,0.82,0.73,0.3,       //green
//        1.0,1.0,1.0,0.9,          //white
//        0.75,0.29,0.85,0.3,       //purple
//        0.85,0.52,0.14,0.8        //Orange
//    };
//    
//    CGColorSpaceRef sp= CGColorSpaceCreateDeviceRGB();
//    CGGradientRef grad= CGGradientCreateWithColorComponents(sp, colors, locs, 5);
//    CGContextDrawLinearGradient(context, grad, CGPointMake(100.0, 0.0), CGPointMake(0, 100), 0);
//    
//    CGColorSpaceRelease(sp);
//    CGGradientRelease(grad);
//    CGContextRestoreGState(context);
//
//}

@end
