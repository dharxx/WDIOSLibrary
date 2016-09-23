//
//  WDIOSPopOverlayViewController.m
//  FoodPlace
//
//  Created by Dhanu Saksrisathaporn on 9/23/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "WDIOSPopOverlayViewController.h"
#import "NSObject+MVCSupport.h"

@interface WDIOSPopOverlayViewController ()
@end

@implementation WDIOSPopOverlayViewController
- (UIImageView *)imageView
{
    if (!_imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, 146, 64)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _imageView;
}
- (UILabel *)label
{
    if (!_label) {
        self.label= [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 146, 56)];
        _label.font = [UIFont boldSystemFontOfSize:24];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.backgroundColor = [UIColor clearColor];
        _label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _label;
}
- (UIView *)backgoundView
{
    if (!_backgoundView) {
        self.backgoundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 186, 186)];
        _backgoundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        _backgoundView.layer.masksToBounds = YES;
        _backgoundView.layer.cornerRadius = 11;
        _backgoundView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _backgoundView;
}
+ (instancetype)popWithSource:(UIViewController *)source
{
    WDIOSPopOverlayViewController *pop = [[WDIOSPopOverlayViewController alloc] init];
    [pop popFromSource:source];
    return pop;
}
- (void)popFromSource:(UIViewController *)source
{
    
    wdios_mainBlock(^{
        source.definesPresentationContext = YES;
        source.providesPresentationContextTransitionStyle = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [source presentViewController:self animated:YES completion:^{
        }];
    });
}
- (void)closeAfter:(NSTimeInterval)delay
{
    // Delay execution of my block for 10 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self close];
    });
}
- (void)close
{
    wdios_mainBlock(^{
        [UIView animateWithDuration:0.2 animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL b){
            [self.presentingViewController dismissViewControllerAnimated:NO completion:^{
            }];
        }];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.backgoundView addSubview:self.label];
    [self.backgoundView addSubview:self.imageView];
    [self.view addSubview:self.backgoundView];
    self.view.backgroundColor = [UIColor clearColor];
    self.backgoundView.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
