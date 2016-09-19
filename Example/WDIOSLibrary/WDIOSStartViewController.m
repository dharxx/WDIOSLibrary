//
//  WDIOSStartViewController.m
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 8/3/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//
#import "WDIOSStartViewController.h"

WDIOSStartViewController *gWDIOSStartViewController = nil;
@interface WDIOSStartViewController ()

@end

@implementation WDIOSStartViewController

- (void)resetApplicationView
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    gWDIOSStartViewController = self;
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    [self performSegueWithIdentifier:@"start" sender:nil];
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
