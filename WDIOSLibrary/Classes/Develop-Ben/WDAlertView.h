//
//  AlertView.h
//  BMUtilityView
//
//  Created by BURIN TECHAMA on 7/15/2559 BE.
//  Copyright © 2559 BURIN TECHAMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDAlertView;
typedef void (^UIAlertViewCompletionBlock) (WDAlertView * alertView, NSInteger buttonIndex);

@interface WDAlertView : UIView

@property (nonatomic, copy) UIAlertViewCompletionBlock buttonDidTappedBlock;

@property (strong, nonatomic) UIView *mainView;

- (void)show;

- (void)dismiss;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
           confirmButtonTitle:(NSString *)confirmButtonTitle
            cancelButtonTitle:(NSString *)cancelButtonTitle
      usingBlockWhenTapButton:(UIAlertViewCompletionBlock)tapBlock;

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

@end

