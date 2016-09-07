//
//  UIViewController+AndriodUI.m
//  Pods
//
//  Created by BURIN TECHAMA on 8/30/2559 BE.
//
//

#import "UIViewController+AndriodUI.h"


@implementation UIViewController (AndroidUI)

-(void)showCircularProgressIndeterminate{
    MDProgress *loadingView = [[MDProgress alloc] initWithFrame:self.view.bounds];
    [loadingView setStyle:MDProgressStyleCircular];
    [loadingView setProgressType:MDProgressTypeIndeterminate];
    [self.view addSubview:loadingView];
}

-(void)showLinearProgressIndeterminate{
    MDProgress *loadingView = [[MDProgress alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 10)];
    [loadingView setStyle:MDProgressStyleLinear];
    [loadingView setProgressType:MDProgressTypeIndeterminate];
    [self.view addSubview:loadingView];
}

-(void)removeProgressView{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[MDProgress class]]) {
            [view removeFromSuperview];
        }
    }
}

-(void)addNavbarSpinner{
//    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
//    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
//    [self navigationItem].rightBarButtonItem = barButton;
//    [activityIndicator startAnimating];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[self navigationItem].rightBarButtonItems];
    [arr addObject:barButton];
    [self navigationItem].rightBarButtonItems = arr;
    [activityIndicator startAnimating];
}

-(void)removeAllNavbarSpinner{
    NSMutableArray *new_arr = [[NSMutableArray alloc]init];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[self navigationItem].rightBarButtonItems];
    for (UIBarButtonItem * barButton in arr) {
        if (![barButton.customView isKindOfClass:[UIActivityIndicatorView class]]) {
            [new_arr addObject:barButton];
        }
    }
    [self navigationItem].rightBarButtonItems = new_arr;
}

@end
