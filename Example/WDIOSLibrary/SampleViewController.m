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

-(void)viewDidLoad{
    [self.textFieldLimit setLimit:5];
    [self.buttonView setTitle:@"Login Now!"];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor CustomSteelBlueColor]];
    
}

-(IBAction)alertMessage:(id)sender{
    [self warningAlertViewWithTitle:@"System Infomation"
                            message:[NSString stringWithFormat:@"Your system version is %@",
                                     [UIDevice currentDevice].systemVersion]
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
    [loadingView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6]];
    [self.view addSubview:loadingView];
    [self performSelector:@selector(removeLoadingView:) withObject:self afterDelay:5];
}

-(IBAction)addLinearLoading:(id)sender{
    MDProgress *loadingView = [[MDProgress alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 8)];
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
            NSLog(@"Canceled");
        }else if(buttonIndex == 1){
            NSLog(@"Deleted");
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

-(IBAction)addEmptyStateView:(id)sender{
    WDEmptyStateView *view = [[WDEmptyStateView alloc]initWithTitle:@"NO DATA" description:@"Your collection list is empty." imageName:@"empty"];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:view];
    [view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:5];
}

-(IBAction)addInternetLostView:(id)sender{
    WDEmptyStateView *view = [[WDEmptyStateView alloc]initWithTitle:@"NO INTERNET" description:@"Your internet connention was lost,\nPlease check." imageName:@"nointernet"];
    [view setBackgroundColor:[UIColor colorWithRed:0.96 green:0.98 blue:1.00 alpha:1.0]];
    [view setTextColor:[UIColor darkGrayColor]];
    [view setActionButtonTextColor:[UIColor whiteColor] AndBackgroundColor:[UIColor CustomCrimsonColor]];
    [view addActionButton:@"Retry" WithHandler:^(WDEmptyStateView *view) {
        WDToastView *toast = [[WDToastView alloc]initWithMessage:@"You press retry : )" iconName:@"" time:ToastShowingTimeShort usingBlockWhenFinishShowing:nil];
        [toast show];
    }];
    [self.view addSubview:view];
    [view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:5];
}

-(IBAction)addNavbarSpinner:(id)sender{
    [self addNavbarSpinner];
}

-(IBAction)removeNavbarSpinner:(id)sender{
    [self removeAllNavbarSpinner];
}

-(IBAction)addLightAlertView:(id)sender{
    WDLightAlertView *alert = [[WDLightAlertView alloc]initWithTitle:@"Warning" Description:@"Diary for Sep 8, 2016 already exist! Do you realy want to overwrite it?" PrimaryButtonTitle:@"Cancel" Completion:^(WDLightAlertView *alert){
        NSLog(@"primary button tapped");
    }];
    [alert addSecondaryButtonWithTitle:@"Overwrite" Completion:^(WDLightAlertView *alert) {
        NSLog(@"secondary button tapped");
    }];
    [alert show];
    
    //[self performSelector:@selector(removeAlertView:) withObject:alert afterDelay:10];
}

-(void)removeAlertView:(WDLightAlertView *)alert{
    [alert dismiss];
}

@end
