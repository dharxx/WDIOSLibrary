//
//  TestUIViewController.m
//  WDIOSLibrary
//
//  Created by BURIN TECHAMA on 9/19/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "TestUIViewController.h"

@interface TestUIViewController ()

@property (nonatomic,retain) NSMutableArray<NSString *> *menuList;

@end

@implementation TestUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareDataForView];
    [self updateUI];
}

-(void)prepareDataForView{
    _menuList = [[NSMutableArray alloc]initWithObjects:@"Add Spinner",@"Remove Spinner",@"Button with Indicator",@"Custom Alert",@"Light Alert",@"Fullscreen Loading",@"Notification View", @"Toast View",@"Custom Color (HTML Name)",@"Empty State View", nil];
    //[self setInitialDatas:_menuList];
}

-(void)updateUI{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"triangle-background-17"]];
    [imageView setFrame:self.view.frame];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view insertSubview:imageView atIndex:0];
    [self setTitle:@"CustomView"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_menuList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _menuList[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *menuName = cell.textLabel.text;
    
    if ([menuName.lowercaseString isEqualToString:@"add spinner"]) {
        [self addNavbarSpinner];
    }else if ([menuName.lowercaseString isEqualToString:@"remove spinner"]) {
        [self removeAllNavbarSpinner];
    }else if ([menuName.lowercaseString isEqualToString:@"button with indicator"]) {
        [self addButtonWithIndicator];
    }else if ([menuName.lowercaseString isEqualToString:@"custom alert"]) {
        [self addCustomAlertView];
    }else if ([menuName.lowercaseString isEqualToString:@"light alert"]) {
        [self addLightAlertView];
    }else if ([menuName.lowercaseString isEqualToString:@"fullscreen loading"]) {
        [self addFullScreenLoading];
    }else if ([menuName.lowercaseString isEqualToString:@"notification view"]) {
        [self addNotificationView];
    }else if ([menuName.lowercaseString isEqualToString:@"toast view"]) {
        [self addToastView];
    }else if ([menuName.lowercaseString isEqualToString:@"custom color (html name)"]) {
        [self inputAlertViewWithTitle:@"What name of color do you want?" textFieldInfo:nil completion:^{
            
        } closeAlertCompletion:^(NSString *inputString) {
            
        }];
    }else if ([menuName.lowercaseString isEqualToString:@"empty state view"]) {
        [self addEmptyStateView];
    }else{
        [self.tableView reloadData];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *menuName = cell.textLabel.text;
    if ([menuName.lowercaseString isEqualToString:@"add spinner"]) {
        return YES;
    }
    return NO;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *menuName = cell.textLabel.text;
    if ([menuName.lowercaseString isEqualToString:@"add spinner"]) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [self removeAllNavbarSpinner];
            [tableView setEditing:NO animated:YES];
        }
    }
}

#pragma mark - Call WDIOS Cuctom View

-(void)addButtonWithIndicator{
    WDButtonIndicator *buttonView = [[WDButtonIndicator alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [buttonView setCenter:self.view.center];
    [buttonView setBackgroundColor:[UIColor whiteColor]];
    [buttonView setTitle:@"PRESS ME!!"];
    [self.view addSubview:buttonView];
    
    [buttonView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:6];
}

-(void)addCustomAlertView{
    WDAlertView *alert = [[WDAlertView alloc]initWithTitle:@"Confirm Delete" message:@"Do you want to delete this item." confirmButtonTitle:@"Delete" cancelButtonTitle:@"No" usingBlockWhenTapButton:^(WDAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            NSLog(@"Canceled");
        }else if(buttonIndex == 1){
            NSLog(@"Deleted");
        }
    }];
    [alert show];
}

-(void)addLightAlertView{
    WDLightAlertView *alert = [[WDLightAlertView alloc]initWithTitle:@"Warning" Description:@"Diary for Sep 8, 2016 already exists! Do you realy want to overwrite it?" PrimaryButtonTitle:@"Cancel" Completion:^(WDLightAlertView *alert){
        NSLog(@"primary button tapped");
    }];
    [alert addSecondaryButtonWithTitle:@"Overwrite" Completion:^(WDLightAlertView *alert) {
        NSLog(@"secondary button tapped");
    }];
    [alert show];
    
    //[self performSelector:@selector(removeAlertView:) withObject:alert afterDelay:10];
}

-(void)addFullScreenLoading{
    WDFullScreenLoading *loading = [[WDFullScreenLoading alloc]init];
    [loading setMessage:@"Processing Transection.."];
    [loading show];
    [loading performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:5];
}

-(void)addNotificationView{
    WDNotificationView *view = [[WDNotificationView alloc]initWithAppName:@"WDIOSLibrary" TimeDesc:@"now" Title:@"Download Complete" Subtitle:@"Your file has been downloaded." iconName:@"sample" timeDelay:5 parentView:self.view style:WDNotificationViewStyleDark usingBlockWhenTapped:^(WDNotificationView *notificationView) {
        NSLog(@"block entered !!");
    }];
    [view show];
}

-(void)addToastView{
    WDToastView *toast = [[WDToastView alloc]initWithMessage:@"Logged in as.. Benmore99"
                                                    iconName:@"sample"
                                                        time:ToastShowingTimeNormal
                                 usingBlockWhenFinishShowing:nil];
    [toast show];
}

-(void)showCustomColor{
    
}

-(void)addEmptyStateView{
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

@end
