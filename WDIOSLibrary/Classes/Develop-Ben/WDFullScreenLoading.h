//
//  WDFullScreenLoading.h
//  Pods
//
//  Created by BURIN TECHAMA on 8/30/2559 BE.
//
//

#import <UIKit/UIKit.h>

@interface WDFullScreenLoading : UIView

@property (nonatomic,strong) UILabel *loadingText;
@property (nonatomic,strong) UIActivityIndicatorView *indicator;
@property (nonatomic,strong) UIView *backgroundView;

-(void)show;
-(void)hide;
-(void)setMessage:(NSString *)msg;

@end
