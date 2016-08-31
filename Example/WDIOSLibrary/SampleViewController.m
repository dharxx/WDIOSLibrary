//
//  SampleViewController.m
//  WDIOSLibrary
//
//  Created by BURIN TECHAMA on 8/29/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "SampleViewController.h"
#import "MDProgress.h"
#import "MDSnackbar.h"

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
    MDProgress *loadingView = [[MDProgress alloc] initWithFrame:self.view.bounds];
    [loadingView setStyle:MDProgressStyleCircular];
    [loadingView setProgressType:MDProgressTypeIndeterminate];
    [self.view addSubview:loadingView];
    [self performSelector:@selector(removeLoadingView:) withObject:self afterDelay:5];
}

-(IBAction)addLinearLoading:(id)sender{
    MDProgress *loadingView = [[MDProgress alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 10)];
    [loadingView setStyle:MDProgressStyleLinear];
    [loadingView setProgressType:MDProgressTypeIndeterminate];
    [self.view addSubview:loadingView];
}

-(IBAction)removeLoadingView:(id)sender{
    [self removeProgressView];
}

-(IBAction)addAlertView:(id)sender{
    AlertView *alert = [[AlertView alloc]initWithTitle:@"Confirm Delete" message:@"Do you want to delete this item." confirmButtonTitle:@"Delete" cancelButtonTitle:@"No" usingBlockWhenTapButton:^(AlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            ToastView *toast = [[ToastView alloc]initWithMessage:@"Canceled"
                                                        iconName:@""
                                                            time:ToastShowingTimeShort
                                     usingBlockWhenFinishShowing:nil];
            [toast show];
        }else if(buttonIndex == 1){
            ToastView *toast = [[ToastView alloc]initWithMessage:@"Deleted"
                                                        iconName:@""
                                                            time:ToastShowingTimeShort
                                     usingBlockWhenFinishShowing:nil];
            [toast show];
        }
    }];
    [alert show];
}

-(IBAction)addSneckbar:(id)sender{
    MDSnackbar *bar = [[MDSnackbar alloc]initWithText:@"No Internet Connectivity, Please check" actionTitle:@"Close" duration:3];
    [bar show];
}

@end
