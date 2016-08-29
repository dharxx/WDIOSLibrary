//
//  SampleViewController.m
//  WDIOSLibrary
//
//  Created by BURIN TECHAMA on 8/29/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "SampleViewController.h"

@implementation SampleViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(IBAction)alertMessage:(id)sender{
    [self warningAlertViewWithTitle:@"Test"
                            message:@"message"
                         completion:^{}
               closeAlertCompletion:^{}];
}

-(IBAction)alertToast:(id)sender{
    ToastView *toast = [[ToastView alloc]initWithMessage:@"Awesome Library" iconName:@"" time:3 usingBlockWhenFinishShowing:nil];
    [toast show];
}

@end
