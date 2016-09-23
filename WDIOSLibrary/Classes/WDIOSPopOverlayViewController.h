//
//  WDIOSPopOverlayViewController.h
//  FoodPlace
//
//  Created by Dhanu Saksrisathaporn on 9/23/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDIOSPopOverlayViewController : UIViewController
@property (nonatomic,retain) UIView *backgoundView;
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UILabel *label;
+ (instancetype)popWithSource:(UIViewController *)source;
- (void)popFromSource:(UIViewController *)source;
- (void)close;
- (void)closeAfter:(NSTimeInterval)delay;
@end
