//
//  ViewController.h
//  TimerActivation
//
//  Created by Ness on 8/28/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    SEL testSelector;
    BOOL running;
    NSRunLoop *loop;
}

@property (weak, nonatomic) IBOutlet UIButton *myButton;
- (IBAction)timerAction:(id)sender;
@property NSTimer *timer;
@end

