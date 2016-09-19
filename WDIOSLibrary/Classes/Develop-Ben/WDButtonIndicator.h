//
//  Button+IndicatorView.h
//  Pods
//
//  Created by BURIN TECHAMA on 8/30/2559 BE.
//
//

#import <UIKit/UIKit.h>

@interface WDButtonIndicator : UIView

@property (nonatomic,strong) UIButton *button;

@property (nonatomic,strong) UIActivityIndicatorView *indicator;

-(void)setTitle:(NSString *)title;
-(void)showSpinner;
-(void)hideSpinner;

@end
