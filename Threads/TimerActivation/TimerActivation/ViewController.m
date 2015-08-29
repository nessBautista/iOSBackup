//
//  ViewController.m
//  TimerActivation
//
//  Created by Ness on 8/28/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myButton,timer;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    running=NO;
    
    testSelector=NSSelectorFromString(@"test");
    loop=[[NSRunLoop alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timerAction:(id)sender {
    if (running) {
        NSString *message=[[NSString alloc]initWithFormat:@"Activate Timer"];
        [myButton setTitle:message forState:normal];
        [self deactivateLoop];
        running=NO;
    }else{
        NSString *message=[[NSString alloc]initWithFormat:@"Stop Timer"];
        [myButton setTitle:message forState:normal];
        [self activateLoop];
        running=YES;
    }
    
    
}
-(void)activateLoop{
    NSLog(@"You pressed the button");
    timer=[NSTimer scheduledTimerWithTimeInterval:1.0/2 target:self selector:@selector(test:) userInfo:nil repeats:YES];
    
}

-(void)deactivateLoop{
    NSLog(@"timer de-activation");
    if (timer) {
        [timer invalidate];
        timer = nil;
    }


}
-(void)test:(NSTimer *)timer{
    NSLog(@"Timer Activated and Running");
}
@end
