//
//  ToastView.m
//  Pods
//
//  Created by BURIN TECHAMA on 8/29/2559 BE.
//
//

#import "ToastView.h"
#define kBarViewMargin 40
#define kBarViewHeight 40

@interface ToastView ()
@property (nonatomic, strong) UILabel *barView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) NSString *textTitle;
@property NSUInteger time;
@property ToastShowingTime showingTime;
@end

@implementation ToastView

- (instancetype)initWithMessage:(NSString *)message
                       iconName:(NSString *)iconName
                           time:(ToastShowingTime )showingTime
    usingBlockWhenFinishShowing:(UIToastViewCompletionBlock)toastBlock{
    
    self = [super init];
    
    if (self) {
        
        self.textTitle = message;
        self.time = showingTime;
        
        // helpers
        CGSize screenSize = [self screenSize];
        CGFloat screenHeight = screenSize.height;
        CGFloat screenWidth = screenSize.width;
        
        // self
        [self setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        [self setClipsToBounds:YES];
        [self setBackgroundColor:[UIColor clearColor]];
        
        //label
        NSString *paddingText = @"";
        self.barView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        if (![iconName isEqualToString:@""]) { paddingText = @"      ";}
        [self.barView setText:[NSString stringWithFormat:@"%@%@",paddingText,self.textTitle]];
        [self.barView setFont:[UIFont systemFontOfSize:15]];
        [self.barView setTextAlignment:NSTextAlignmentCenter];
        [self.barView sizeToFit];
        [self.barView setFrame:CGRectMake(screenWidth/2 - self.barView.frame.size.width/2 - kBarViewMargin/2,
                                          screenHeight - (self.barView.frame.size.height + 60),
                                          self.barView.frame.size.width + kBarViewMargin,
                                          self.barView.frame.size.height + 20)];
        [self.barView.layer setMasksToBounds:YES];
        [self.barView.layer setCornerRadius:self.barView.frame.size.height/2];
        [self.barView setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.5]];
        [self.barView setTextColor:[UIColor whiteColor]];
        [self addSubview:self.barView];
        
        //icon
        if (![iconName isEqualToString:@""]) {
            self.iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:iconName]];
            [self.iconImageView setFrame:CGRectMake(7, self.barView.frame.size.height/2-15, 30, 30)];
            [self.iconImageView setClipsToBounds:YES];
            [self.iconImageView.layer setCornerRadius:15];
            [self.barView addSubview:self.iconImageView];
        }
        
        // Motion effects
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-10);
        horizontalMotionEffect.maximumRelativeValue = @(10);
        
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalMotionEffect.minimumRelativeValue = @(-10);
        verticalMotionEffect.maximumRelativeValue = @(10);
        
        UIMotionEffectGroup *group = [UIMotionEffectGroup new];
        group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
        [self.barView addMotionEffect:group];
    }
    
    self.toastDidFinishShowing = toastBlock;
    
    return self;
}

- (void)show{
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            [window addSubview:self];
            break;
        }
    }
    
    self.barView.layer.opacity = 0.5f;
    [self.barView setFrame:CGRectMake(self.barView.frame.origin.x,
                                      self.barView.frame.origin.y + 20,
                                      self.barView.frame.size.width,
                                      self.barView.frame.size.height)];
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.barView.layer.opacity = 1.0f;
                         [self.barView setFrame:CGRectMake(self.barView.frame.origin.x,
                                                           self.barView.frame.origin.y - 20,
                                                           self.barView.frame.size.width,
                                                           self.barView.frame.size.height)];
                     }completion:^(BOOL finished) {
                         [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.time];
                     }];
    
    
}

-(void)dismiss{
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         [self.barView setFrame:CGRectMake(self.barView.frame.origin.x,
                                                           self.barView.frame.origin.y + 20,
                                                           self.barView.frame.size.width,
                                                           self.barView.frame.size.height)];
                         self.barView.alpha = 0.0f;
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         [self performSelector:@selector(removeFromSuperview) withObject:self];
                     }];
}

// Helper function: count and return the screen's size
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
