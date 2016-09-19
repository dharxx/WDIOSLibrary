//
//  UIViewController+DevelopBen.m
//  Pods
//
//  Created by BURIN TECHAMA on 9/19/2559 BE.
//
//

#import "UIViewController+DevelopBen.h"

@implementation UIViewController (DevelopBen)

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
