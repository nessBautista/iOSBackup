//
//  ViewController.m
//  DrawingOnLayers
//
//  Created by Ness on 7/29/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import "ViewController.h"
#import "myView.h"
#import "myLayer.h"
#import "testView.h"
@interface ViewController (){
    myView *mv;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    testView *tv=[[testView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    tv.backgroundColor=[UIColor orangeColor];
//    [self.view addSubview:tv];
    
    mv=[[myView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];

    //mv.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:mv];
    mv.layer.cornerRadius=20.0;


    
}
- (IBAction)updateAction:(id)sender {
    //SetNeedsDisplay calls -drawRect if is defined in the UIView subclass
    //[mv setNeedsDisplay];
    
    //setNeedsLayout calls -layoutSublayers which is the method defined when the CALayer is initialized
    [mv setNeedsLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
