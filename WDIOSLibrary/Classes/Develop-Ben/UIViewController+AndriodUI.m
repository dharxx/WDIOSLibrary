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

@end
