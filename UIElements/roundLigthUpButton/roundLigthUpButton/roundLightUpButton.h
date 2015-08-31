//
//  roundLightUpButton.h
//  roundLigthUpButton
//
//  Created by Ness on 8/30/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface roundLightUpButton : UIControl{
    CGFloat W;
    CGFloat H;
    CGPoint startCenter;
    
    CGFloat redComponent;
    CGFloat greenComponent;
    CGFloat blueComponent;
    CGFloat alphaComponent;
    
    UITextField *effectDescription;

    BOOL active;
}

@property UIColor *color;
@property NSString *buttonName;
@end
