//
//  AlertView.m
//  BMUtilityView
//
//  Created by BURIN TECHAMA on 7/15/2559 BE.
//  Copyright © 2559 BURIN TECHAMA. All rights reserved.
//

#import "WDAlertView.h"

#define kOpinionzAlertWidth   280
#define kOpinionzButtonHeight 40
#define kOpinionzTitleHeight  40
#define kOpinionzHeaderHeight 120

#define kOpinionzTitleLeftMargin 10
#define kOpinionzTitleRightMargin 10
#define kOpinionzMessageLeftMargin 10
#define kOpinionzMessageRightMargin 10

#define kOpinionzDefaultHeaderColor  [UIColor whiteColor]
#define kOpinionzSeparatorColor      [UIColor colorWithRed:0.724 green:0.727 blue:0.731 alpha:1.000]
#define kOpinionzBlueTitleColor      [UIColor colorWithRed:0.071 green:0.431 blue:0.965 alpha:1]
#define kOpinionzLightBlueTitleColor [UIColor colorWithRed:0.071 green:0.431 blue:0.965 alpha:0.4]

#define kButtonMargin 10
#define kConfirmButtonColor [UIColor colorWithRed:0.40 green:0.80 blue:0.00 alpha:1.00]

@interface WDAlertView ()

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSString *confirmButtonTitle;

@end

#pragma mark - initializers



@implementation WDAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
           confirmButtonTitle:(NSString *)confirmButtonTitle
            cancelButtonTitle:(NSString *)cancelButtonTitle
      usingBlockWhenTapButton:(UIAlertViewCompletionBlock)tapBlock
{
    self = [super init];
    
    if (self) {
        self.confirmButtonTitle = confirmButtonTitle;
        self.cancelButtonTitle = cancelButtonTitle;
        
        // helpers
        CGSize screenSize = [self screenSize];
        CGFloat screenHeight = screenSize.height;
        CGFloat screenWidth = screenSize.width;
        CGFloat headerHeight = kOpinionzHeaderHeight;
        CGFloat titleHeight = kOpinionzTitleHeight;
        
        // self
        [self setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        [self setClipsToBounds:YES];
        [self setBackgroundColor:[UIColor clearColor]];
        
        // buttons height calculation
        CGFloat buttonsHeight = 44;
        
        // alert height calculation
        //CGFloat boundingRectHeight = [self boundingRectHeightWithText:message font:[UIFont systemFontOfSize:14]];
        CGFloat alertHeight = 250;
        
        // alert view
        self.alertView = [[UIView alloc] initWithFrame:CGRectMake((screenWidth - kOpinionzAlertWidth)/2,
                                                                  (screenHeight - alertHeight)/2, kOpinionzAlertWidth, alertHeight)];
        [self.alertView setBackgroundColor:[UIColor whiteColor]];
        self.alertView.layer.masksToBounds = YES;
        self.alertView.layer.cornerRadius = 5;
        [self addSubview:self.alertView];
        
        // header view
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.alertView.bounds), headerHeight)];
        [self.headerView setBackgroundColor:kOpinionzDefaultHeaderColor];
        [self.alertView addSubview:self.headerView];
        
        // icon imageview
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.headerView.bounds) - 72)/2,
                                                                           (CGRectGetHeight(self.headerView.bounds) - 72)/2, 72, 72)];
        [self.iconImageView setUserInteractionEnabled:YES];
        [self.iconImageView setContentMode:UIViewContentModeScaleAspectFit];
        self.iconImageView.autoresizingMask = ( UIViewAutoresizingFlexibleBottomMargin
                                               | UIViewAutoresizingFlexibleHeight
                                               | UIViewAutoresizingFlexibleLeftMargin
                                               | UIViewAutoresizingFlexibleRightMargin
                                               | UIViewAutoresizingFlexibleTopMargin
                                               | UIViewAutoresizingFlexibleWidth );
        [self.headerView addSubview:self.iconImageView];
        
        // title label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kOpinionzTitleLeftMargin, CGRectGetHeight(self.headerView.frame), CGRectGetWidth(self.alertView.bounds) - kOpinionzTitleLeftMargin - kOpinionzTitleRightMargin, titleHeight)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setText:title];
        [titleLabel setFont:[self titleFont]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.alertView addSubview:titleLabel];
        
        // message view
        CGFloat newLineHeight = [self boundingRectHeightWithText:message font:[self messageFont]];
        UITextView *messageView = [[UITextView alloc] initWithFrame:CGRectMake(kOpinionzTitleLeftMargin, CGRectGetHeight(titleLabel.frame) + CGRectGetHeight(self.headerView.frame) - 10, CGRectGetWidth(self.alertView.bounds) - kOpinionzMessageLeftMargin - kOpinionzMessageRightMargin, newLineHeight)];
        [messageView setText:message];
        [messageView setFont:[self messageFont]];
        [messageView setTextColor:[UIColor blackColor]];
        [messageView setTextAlignment:NSTextAlignmentCenter];
        [messageView setEditable:NO];
        [messageView setUserInteractionEnabled:NO];
        [messageView setDataDetectorTypes:UIDataDetectorTypeNone];
        [messageView setBackgroundColor:[UIColor clearColor]];
        [self.alertView addSubview:messageView];
        
        // buttons view
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, alertHeight - buttonsHeight- kButtonMargin, kOpinionzAlertWidth, buttonsHeight)];
        [buttonView setBackgroundColor:[UIColor clearColor]];
        [self.alertView addSubview:buttonView];
        
        // horizontal separator
//        CALayer *horizontalBorder = [self separatorAt:CGRectMake(0, 0, buttonView.frame.size.width, 0.5)];
//        [buttonView.layer addSublayer:horizontalBorder];
        
        // adds border between 2 buttons
//        CALayer *centerBorder = [CALayer layer];
//        centerBorder.frame = CGRectMake((CGRectGetWidth(buttonView.frame) - 0.5)/2, 0.0f, 0.5f, CGRectGetHeight(buttonView.frame));
//        centerBorder.backgroundColor = [UIColor blackColor].CGColor;
//        [buttonView.layer addSublayer:centerBorder];
//        [self.alertView addSubview:buttonView];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];

        // Cancel button & 1 other button
        cancelButton.frame = CGRectMake(kButtonMargin, 0, kOpinionzAlertWidth/2 - kButtonMargin - kButtonMargin/2, kOpinionzButtonHeight);

        
        [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [cancelButton setBackgroundColor:[UIColor lightGrayColor]];
        [cancelButton.layer setCornerRadius:3];
        [cancelButton addTarget:self action:@selector(alertButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTag:0];
        [buttonView addSubview:cancelButton];
        
        UIButton *otherTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        otherTitleButton.tag = 1;
        otherTitleButton.frame = CGRectMake(kOpinionzAlertWidth/2 + kButtonMargin/2, 0, kOpinionzAlertWidth/2 - kButtonMargin - kButtonMargin/2, kOpinionzButtonHeight);
        [otherTitleButton addTarget:self action:@selector(alertButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        [otherTitleButton setTitle:confirmButtonTitle forState:UIControlStateNormal];
        [otherTitleButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [otherTitleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [otherTitleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [otherTitleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [otherTitleButton setBackgroundColor:kConfirmButtonColor];
        [otherTitleButton.layer setCornerRadius:3];
        [buttonView addSubview:otherTitleButton];
        
        // Motion effects
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-10);
        horizontalMotionEffect.maximumRelativeValue = @(10);
        
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalMotionEffect.minimumRelativeValue = @(-10);
        verticalMotionEffect.maximumRelativeValue = @(10);
        
        UIMotionEffectGroup *group = [UIMotionEffectGroup new];
        group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
        [self.alertView addMotionEffect:group];
        
    }
    
    self.buttonDidTappedBlock = tapBlock;
    
    return self;
}

// MARK: Setters/Getters
- (UIFont *)titleFont {
    return [UIFont boldSystemFontOfSize:20];
}

- (UIFont *)messageFont {
    return [UIFont systemFontOfSize:14];
}

- (UIFont *)buttonsFont {
    return [UIFont systemFontOfSize:17];
}

- (UIFont *)cancelButtonFont {
    return [UIFont boldSystemFontOfSize:16];
}

// Helper function: line for buttons
- (CALayer *)separatorAt:(CGRect)rect {
    CALayer *border = [CALayer layer];
    border.frame = rect;
    border.backgroundColor = kOpinionzSeparatorColor.CGColor;
    return border;
}

// Helper function: get text height with string and font
- (CGFloat)boundingRectHeightWithText:(NSString *)text font:(UIFont *)font {
    CGSize maximumSize = CGSizeMake(270, CGFLOAT_MAX);
    CGRect boundingRect = [text boundingRectWithSize:maximumSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{ NSFontAttributeName : font} context:nil];
    return boundingRect.size.height + 10;
}

- (void)alertButtonDidTapped:(UIButton *)button {
    
    if (self.buttonDidTappedBlock != nil) {
        self.buttonDidTappedBlock(self, button.tag);
    }
    
    [self dismiss];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.mainView.layer setCornerRadius:3];
}


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex {
    
    NSString *buttonTitle;
    
    if (buttonIndex == 0) {
        
        buttonTitle = self.cancelButtonTitle;
    }
    else if(buttonIndex == 1) {
        
        buttonTitle = self.confirmButtonTitle;
    }
    return buttonTitle;
}

-(void)setup{
    
}

-(void)show{
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
    
    self.headerView.backgroundColor = kOpinionzDefaultHeaderColor;
    
    [self.iconImageView setImage:[UIImage imageNamed:@"alert-icon"]];
    
    self.alertView.layer.opacity = 0.5f;
    self.alertView.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.0);
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                         self.alertView.layer.opacity = 1.0f;
                         self.alertView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL];
}

-(void)dismiss{
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.alertView.transform = CGAffineTransformScale(self.alertView.transform, 0.8f, 0.8f);
                         self.alertView.alpha = 0.0f;
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
