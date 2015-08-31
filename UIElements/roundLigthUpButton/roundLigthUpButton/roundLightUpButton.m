//
//  roundLightUpButton.m
//  roundLigthUpButton
//
//  Created by Ness on 8/30/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "roundLightUpButton.h"

@implementation roundLightUpButton
@synthesize color,buttonName;
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        W=self.bounds.size.width;
        H=self.bounds.size.height;
        startCenter=CGPointMake(W/2, H/2);
        active=NO;
        
        
        ////--- Create a font for display message, and get its size
        
        
        UIFont *font=[UIFont fontWithName:@"Futura-CondensedExtraBold" size:18];
        NSString *str=@"D I S T O R T I O N";
        NSDictionary *attributes = [[NSDictionary alloc]initWithObjectsAndKeys:font,NSFontAttributeName, nil];
        CGSize fontSize= [str sizeWithAttributes:attributes];
        
        effectDescription=[[UITextField alloc]initWithFrame:CGRectMake((W/2)-fontSize.width/2,(H/2)-fontSize.height,
                                                                       fontSize.width , fontSize.height)];
        effectDescription.font=font;
        effectDescription.enabled=NO;
        effectDescription.textAlignment=NSTextAlignmentCenter;
        [self addSubview:effectDescription];
        
    }
    return self;
}



-(void)setValue:(id)value forKeyPath:(NSString *)keyPath{
    if ([keyPath isEqualToString:@"color"]) {
        color=value;
        const CGFloat *components=CGColorGetComponents(color.CGColor);
        redComponent=components[0];
        greenComponent=components[1];
        blueComponent=components[2];
        alphaComponent=0.9;
    }
    
    if ([keyPath isEqualToString:@"buttonName"]) {
        buttonName=value;
        effectDescription.text=buttonName;
        
    }

}

- (void)drawRect:(CGRect)rect {
    CGContextRef context= UIGraphicsGetCurrentContext();
    if (!active) {
        //-- Create a circular mask
        UIGraphicsBeginImageContext(self.bounds.size);
        CGContextRef maskContext= UIGraphicsGetCurrentContext();
        CGContextFillEllipseInRect(maskContext, CGRectInset(self.bounds, W*0.10, H*0.10));
        //CGContextSetLineWidth(maskContext, 20);
        //CGContextStrokeEllipseInRect(maskContext, CGRectInset(self.bounds, W*0.10, H*0.10));
        CGContextStrokePath(maskContext);
        CGImageRef mask=CGBitmapContextCreateImage(maskContext);
        //-- Clip mask to context
        CGContextClipToMask(context, self.bounds, mask);
        CGImageRelease(mask);
        UIGraphicsEndImageContext();
        //-- Before draw the gradient save the current context
        
        CGContextSaveGState(context);
        
        //-- Create arrays for locations and colors
        CGFloat locations[4]={1.0,0.0,0.401554,0.538860};
        
        
        CGFloat colors[16]={
            255/255.0,          255/255.0,          255/255.0,              0.3,
            redComponent,       greenComponent,     blueComponent,          0.3,            //
            redComponent-0.01,  greenComponent-0.01,blueComponent-0.01,     0.6,          //
            250/255.0,          240/255.0,          250/255.0,              0.0        //
            
        };
        
        //-- Create and draw gradient
        CGColorSpaceRef colorspace=CGColorSpaceCreateDeviceRGB();
        CGGradientRef grad = CGGradientCreateWithColorComponents(colorspace, colors, locations, 4);
        //CGContextDrawLinearGradient(context, grad, CGPointMake(0, H/2), CGPointMake(W, H/2), 0);
        CGContextDrawRadialGradient(context, grad, startCenter, W*0.01, CGPointMake(W/2, H/2), W*0.90, kCGGradientDrawsBeforeStartLocation);
        CGColorSpaceRelease(colorspace);
        CGGradientRelease(grad);
        
        CGContextRestoreGState(context);
        active=YES;
        effectDescription.textColor=[UIColor blackColor];
    }else {
        //-- Create a circular mask
        UIGraphicsBeginImageContext(self.bounds.size);
        CGContextRef maskContext= UIGraphicsGetCurrentContext();
        CGContextFillEllipseInRect(maskContext, CGRectInset(self.bounds, W*0.10, H*0.10));
        //CGContextSetLineWidth(maskContext, 20);
        //CGContextStrokeEllipseInRect(maskContext, CGRectInset(self.bounds, W*0.10, H*0.10));
        CGContextStrokePath(maskContext);
        CGImageRef mask=CGBitmapContextCreateImage(maskContext);
        //-- Clip mask to context
        CGContextClipToMask(context, self.bounds, mask);
        CGImageRelease(mask);
        UIGraphicsEndImageContext();
        //-- Before draw the gradient save the current context
        
        CGContextSaveGState(context);
        
        //-- Create arrays for locations and colors
        CGFloat locations[4]={1.0,0.0,0.401554,0.538860};
        
        
        CGFloat colors[16]={
            255/255.0,          255/255.0,          255/255.0,              0.3,
            redComponent,       greenComponent,     blueComponent,          0.1,            //
            redComponent-0.01,  greenComponent-0.01,blueComponent-0.01,     0.2,          //
            250/255.0,          240/255.0,          250/255.0,              0.1        //
            
        };
        
        //-- Create and draw gradient
        CGColorSpaceRef colorspace=CGColorSpaceCreateDeviceRGB();
        CGGradientRef grad = CGGradientCreateWithColorComponents(colorspace, colors, locations, 4);
        //CGContextDrawLinearGradient(context, grad, CGPointMake(0, H/2), CGPointMake(W, H/2), 0);
        CGContextDrawRadialGradient(context, grad, startCenter, W*0.01, CGPointMake(W/2, H/2), W*0.90, kCGGradientDrawsBeforeStartLocation);
        CGColorSpaceRelease(colorspace);
        CGGradientRelease(grad);
        
        CGContextRestoreGState(context);
        CGContextSetLineWidth(context, 12);
        [[UIColor blackColor]set];
        CGContextStrokeEllipseInRect(context, CGRectInset(self.bounds, W*0.12, H*0.12));
        active=NO;
        effectDescription.textColor=[UIColor whiteColor];
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
}
@end
