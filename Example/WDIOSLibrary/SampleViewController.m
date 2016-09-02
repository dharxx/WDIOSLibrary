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
#import "MDToast.h"

@implementation SampleViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor CustomSteelBlueColor]];
    
}

-(IBAction)alertMessage:(id)sender{
    [self warningAlertViewWithTitle:@"Test"
                            message:@"message"
                         completion:^{}
               closeAlertCompletion:^{}];
}

-(IBAction)alertToast:(id)sender{
    WDToastView *toast = [[WDToastView alloc]initWithMessage:@"Logged in as.. Benmore99"
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
    WDAlertView *alert = [[WDAlertView alloc]initWithTitle:@"Confirm Delete" message:@"Do you want to delete this item." confirmButtonTitle:@"Delete" cancelButtonTitle:@"No" usingBlockWhenTapButton:^(WDAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            WDToastView *toast = [[WDToastView alloc]initWithMessage:@"Canceled"
                                                        iconName:@""
                                                            time:ToastShowingTimeShort
                                     usingBlockWhenFinishShowing:nil];
            [toast show];
        }else if(buttonIndex == 1){
            WDToastView *toast = [[WDToastView alloc]initWithMessage:@"Deleted"
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
    [bar setMultiline:YES];
    [bar setActionTitleColor:[UIColor colorWithRed:0.27 green:0.62 blue:0.18 alpha:1.0]];
    [bar show];
}

-(IBAction)addMultiLineToast:(id)sender{
    MDToast *toast = [[MDToast alloc]initWithText:@"Account has been created, Please verify your Email" duration:3];
    [toast show];
}

-(IBAction)addNotiMessage:(id)sender{
    WDNotificationView *view = [[WDNotificationView alloc]initWithAppName:@"WDIOSLibrary" TimeDesc:@"now" Title:@"Download Complete" Subtitle:@"Your file has been downloaded." iconName:@"sample" timeDelay:5 parentView:self.view style:WDNotificationViewStyleDark usingBlockWhenTapped:^(WDNotificationView *notificationView) {
        NSLog(@"block entered !!");
    }];
    [view show];
}

@end
