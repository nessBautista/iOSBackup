//
//  ViewController.h
//  SimpleClient
//
//  Created by Ness on 9/6/15.
//  Copyright (c) 2015 Ness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *greetingId;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent;


- (IBAction)fetchGreeting;
@end

