//
//  SampleViewController.m
//  WDIOSLibrary
//
//  Created by BURIN TECHAMA on 8/29/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "SampleViewController.h"
#import "MDProgress.h"

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
    ToastView *toast = [[ToastView alloc]initWithMessage:@"Logged in as.. Benmore99"
                                                iconName:@"sample"
                                                    time:ToastShowingTimeNormal
                             usingBlockWhenFinishShowing:nil];
    [toast show];
}

- (IBAction)addFullScreenLoading:(id)sender {
    WDFullScreenLoading *loading = [[WDFullScreenLoading alloc]init];
    [loading setMessage:@"Processing Transection.."];
    [loading show];
    [self performSelector:@selector(completeLoading:) withObject:loading afterDelay:5];
}

-(void)completeLoading:(WDFullScreenLoading *)loading{
    [loading hide];
}

-(IBAction)addCircularLoading:(id)sender{
    [self showCircularProgressIndeterminate];
    [self performSelector:@selector(removeLoadingView:) withObject:self afterDelay:5];
}

-(IBAction)addLinearLoading:(id)sender{
    [self showLinearProgressIndeterminate];
}

-(IBAction)removeLoadingView:(id)sender{
    [self removeProgressView];
}


@end
