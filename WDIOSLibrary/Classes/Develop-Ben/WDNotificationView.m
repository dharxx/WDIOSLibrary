//
//  WDNotificationView.m
//  Pods
//
//  Created by BURIN TECHAMA on 9/1/2559 BE.
//
//

#import "WDNotificationView.h"

@interface WDNotificationView()
@property (nonatomic,strong) UIView *MessageView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UILabel *AppnameLable;
@property (nonatomic,strong) UILabel *TimeLable;
@property (nonatomic,strong) UILabel *TitleLable;
@property (nonatomic,strong) UILabel *SubtitleLable;
@property (nonatomic,strong) UIImageView *IconImage;
@property (nonatomic,strong) UITapGestureRecognizer *gesture;
@property UIColor *fontColor;
@property NSTimeInterval delayTime;
@end


@implementation WDNotificationView

-(instancetype)initWithAppName:(NSString *)appname
                      TimeDesc:(NSString *)timedesc
                         Title:(NSString *)title
                      Subtitle:(NSString *)subtitle
                      iconName:(NSString *)iconName
                     timeDelay:(NSTimeInterval)time
                    parentView:(UIView *)parentView
                         style:(WDNotificationViewStyle)style
          usingBlockWhenTapped:(UINotificationViewdidTapped)tapBlock{
    
    self = [super init];
    
    if (self) {
        
        self.delayTime = time;
        
        if (style==WDNotificationViewStyleLight) {
            self.fontColor = [UIColor blackColor];
        }else{
            self.fontColor = [UIColor whiteColor];
        }
        
        CGSize screenSize = [self screenSize];
        CGFloat screenHeight = screenSize.height;
        CGFloat screenWidth = screenSize.width;
        
        [self setFrame:CGRectMake(0, 0, screenWidth, 120)];
        [self setClipsToBounds:YES];
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.MessageView = [[UIView alloc]initWithFrame:CGRectMake(8, 20, screenWidth-16, 90)];
        [self.MessageView setBackgroundColor:[UIColor clearColor]];
        [self.MessageView.layer setCornerRadius:10];
        
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth-16, 35)];
        if (style == WDNotificationViewStyleLight) {
            [self.headerView setBackgroundColor:[UIColor whiteColor]];
        }else{
            [self.headerView setBackgroundColor:[UIColor blackColor]];
        }
        [self.headerView setAlpha:0.3];
        UIBezierPath *maskPath;
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.headerView.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                               cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.headerView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.headerView.layer.mask = maskLayer;
        
        self.IconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:iconName]];
        [self.IconImage setFrame:CGRectMake(8, 8, 20, 20)];
        [self.IconImage setClipsToBounds:YES];
        [self.IconImage.layer setCornerRadius:5];
        
        self.AppnameLable = [[UILabel alloc]initWithFrame:CGRectMake(8+20+8, 8, 200, 20)];
        [self.AppnameLable setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightLight]];
        [self.AppnameLable setTextColor:self.fontColor];
        [self.AppnameLable setText:appname];
        
        self.TimeLable = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth-100, 8, 100-32, 20)];
        [self.TimeLable setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightLight]];
        [self.TimeLable setTextAlignment:NSTextAlignmentRight];
        [self.TimeLable setTextColor:self.fontColor];
        [self.TimeLable setText:timedesc];
        
        self.TitleLable = [[UILabel alloc]initWithFrame:CGRectMake(16, 40, screenWidth-48, 20)];
        [self.TitleLable setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]];
        [self.TitleLable setTextColor:self.fontColor];
        [self.TitleLable setText:title];
        
        self.SubtitleLable = [[UILabel alloc]initWithFrame:CGRectMake(16, 60, screenWidth-48, 20)];
        [self.SubtitleLable setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]];
        [self.SubtitleLable setTextColor:self.fontColor];
        [self.SubtitleLable setText:subtitle];
        
        if ([UIBlurEffect class]) {
            if (!UIAccessibilityIsReduceTransparencyEnabled()) {
                
                UIBlurEffect *blurEffect;
                if (style == WDNotificationViewStyleLight) {
                    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
                }else{
                    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
                }
                UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                blurEffectView.frame = parentView.frame;
                blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [blurEffectView setFrame:CGRectMake(0, 0, self.MessageView.frame.size.width,self.MessageView.frame.size.height)];
                [blurEffectView.layer setCornerRadius:10];
                [blurEffectView setClipsToBounds:YES];
                
                [self.MessageView addSubview:blurEffectView];
            }else{
                [self.MessageView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
            }
        }else{
            [self.MessageView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        }
        
        [self.MessageView addSubview:self.headerView];
        [self.MessageView addSubview:self.IconImage];
        [self.MessageView addSubview:self.TimeLable];
        [self.MessageView addSubview:self.AppnameLable];
        [self.MessageView addSubview:self.TitleLable];
        [self.MessageView addSubview:self.SubtitleLable];
        [self addSubview:self.MessageView];
        
        //Add Gesture
        self.gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureTapped:)];
        [self addGestureRecognizer:self.gesture];
        
        // Motion effects
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-10);
        horizontalMotionEffect.maximumRelativeValue = @(10);
        
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalMotionEffect.minimumRelativeValue = @(-10);
        verticalMotionEffect.maximumRelativeValue = @(10);
        
        UIMotionEffectGroup *group = [UIMotionEffectGroup new];
        group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
        [self.MessageView addMotionEffect:group];
        
        
        
    }
    
    self.viewDidTapped = tapBlock;
    
    return self;
}

- (void)show{
    
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            for (WDNotificationView *view in window.subviews) {
                if ([view isKindOfClass:[WDNotificationView class]]) {
                    [view dismiss];
                }
            }
            [window addSubview:self];
            break;
        }
    }
    
    self.MessageView.layer.opacity = 0.5f;
    [self.MessageView setFrame:CGRectMake(self.MessageView.frame.origin.x,
                                      self.MessageView.frame.origin.y - 20,
                                      self.MessageView.frame.size.width,
                                      self.MessageView.frame.size.height)];
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.MessageView.layer.opacity = 1.0f;
                         [self.MessageView setFrame:CGRectMake(self.MessageView.frame.origin.x,
                                                           self.MessageView.frame.origin.y + 20,
                                                           self.MessageView.frame.size.width,
                                                           self.MessageView.frame.size.height)];
                     }completion:^(BOOL finished) {
                         [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.delayTime];
                     }];
    
}

-(void)dismiss{
    
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         [self.MessageView setFrame:CGRectMake(self.MessageView.frame.origin.x,
                                                           self.MessageView.frame.origin.y - 20,
                                                           self.MessageView.frame.size.width,
                                                           self.MessageView.frame.size.height)];
                         self.MessageView.alpha = 0.0f;
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         [self performSelector:@selector(removeFromSuperview) withObject:self];
                     }];
}

-(void)gestureTapped:(id)sender{
    if (self.viewDidTapped != nil) {
        self.viewDidTapped(self);
    }
    [self dismiss];
}

- (CGSize)screenSize
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // On iOS7, screen width and height doesn't automatically follow orientation
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            CGFloat tmp = screenWidth;
            screenWidth = screenHeight;
            screenHeight = tmp;
        }
    }
    
    return CGSizeMake(screenWidth, screenHeight);
}

@end
