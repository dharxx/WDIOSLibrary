//
//  WDLightAlertView.m
//  Pods
//
//  Created by BURIN TECHAMA on 9/7/2559 BE.
//
//

#import "WDLightAlertView.h"
#import "GradientLayer.h"

#define MARGIN4 4
#define MARGIN8 8
#define MARGIN16 16


@interface WDLightAlertView()
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *descriptionLable;
@property (nonatomic,strong) UIButton *primaryButton;
@property (nonatomic,strong) UIButton *secondaryButton;

@end

@implementation WDLightAlertView

-(instancetype)initWithTitle:(NSString *)title
                 Description:(NSString *)description
          PrimaryButtonTitle:(NSString *)primaryBottonTitle
                  Completion:(WDLightAlertViewCompletionBlock)buttonDidTapped{
    self = [super init];
    if (self) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        UIColor *grayColor1 = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
        UIColor *grayColor2 = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        
        [self setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        [self setClipsToBounds:YES];
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
        
        GradientLayer *gradientLayer = [GradientLayer new];
        gradientLayer.frame = self.bounds;
        [self.layer addSublayer:gradientLayer];
        
        self.alertView = [[UIView alloc]init];
        [self.alertView setFrame:CGRectMake(0, 0, screenWidth-MARGIN8*2, 168)];
        [self.alertView setBackgroundColor:[UIColor whiteColor]];
        [self.alertView.layer setCornerRadius:3];
        [self.alertView setCenter:self.center];
        [self addSubview:self.alertView];
        
        self.titleLabel = [[UILabel alloc]init];
        [self.titleLabel setText:title];
        [self.titleLabel setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setFrame:CGRectMake(MARGIN8,
                                             MARGIN16,
                                             self.alertView.frame.size.width-MARGIN8*2,
                                             20)];
        [self.alertView addSubview:self.titleLabel];
        
        self.descriptionLable = [[UILabel alloc]init];
        [self.descriptionLable setText:description];
        [self.descriptionLable setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightRegular]];
        [self.descriptionLable setTextAlignment:NSTextAlignmentCenter];
        [self.descriptionLable setNumberOfLines:0];
        [self.descriptionLable setTextColor:grayColor1];
        [self.descriptionLable setFrame:CGRectMake(MARGIN8,
                                             self.titleLabel.frame.origin.y +
                                             self.titleLabel.frame.size.height + MARGIN16,
                                             self.alertView.frame.size.width-MARGIN8*2,
                                             48)];
        [self.alertView addSubview:self.descriptionLable];
        
        self.primaryButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.primaryButton setTitle:primaryBottonTitle forState:UIControlStateNormal];
        [self.primaryButton setTitleColor:grayColor1 forState:UIControlStateNormal];
        [self.primaryButton.titleLabel setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium]];
        [self.primaryButton setBackgroundColor:grayColor2];
        [self.primaryButton setFrame:CGRectMake(self.alertView.frame.size.width/2 -70,
                                                self.descriptionLable.frame.origin.y +
                                                self.descriptionLable.frame.size.height + MARGIN16, 140, 44)];
        [self.primaryButton.layer setCornerRadius:3];
        [self.primaryButton addTarget:self action:@selector(primaryButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        self.primaryButton.layer.masksToBounds = NO;
        self.primaryButton.layer.borderWidth = 1;
        self.primaryButton.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.0].CGColor;
        
        [self.alertView addSubview:self.primaryButton];
        
        self.alertView.layer.masksToBounds = NO;
        self.alertView.layer.shadowOffset = CGSizeMake(0, 0);
        self.alertView.layer.shadowRadius = 10;
        self.alertView.layer.shadowOpacity = 0.5;
        
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
    self.primaryButtonDidTapped = buttonDidTapped;
    return self;
}

-(void)addSecondaryButtonWithTitle:(NSString*)secondaryButtontitle
                        Completion:(WDLightAlertViewCompletionBlock)buttonDidTapped{
    UIColor *customRedColor = [UIColor colorWithRed:0.96 green:0.37 blue:0.31 alpha:1.0];
    
    self.secondaryButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.secondaryButton setFrame:self.primaryButton.frame];
    [self.secondaryButton setTitle:secondaryButtontitle forState:UIControlStateNormal];
    [self.secondaryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.secondaryButton.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
    [self.secondaryButton setBackgroundColor:customRedColor];
    [self.secondaryButton setFrame:CGRectMake(self.secondaryButton.frame.origin.x + 70 + MARGIN4,
                                              self.primaryButton.frame.origin.y, 140, 44)];
    [self.secondaryButton.layer setCornerRadius:3];
    [self.secondaryButton addTarget:self action:@selector(secondaryButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.secondaryButton.layer.masksToBounds = NO;
    self.secondaryButton.layer.borderWidth = 1;
    self.secondaryButton.layer.borderColor = [UIColor colorWithRed:0.88 green:0.34 blue:0.28 alpha:1.0].CGColor;
    
    [self.alertView addSubview:self.secondaryButton];
    
    [self.primaryButton setFrame:CGRectMake(self.primaryButton.frame.origin.x - 70 - MARGIN4,
                                            self.primaryButton.frame.origin.y, 140, 44)];
    
    self.secondaryButtonDidTapped = buttonDidTapped;
}

-(void)setBankgroundColor:(UIColor*)color{
    if (color!=nil) {
        [self.alertView setBackgroundColor:color];
    }
}

-(void)setTitleColor:(UIColor*)color{
    if (color!=nil) {
        [self.titleLabel setTextColor:color];
    }
}

-(void)setDescriptionColor:(UIColor*)color{
    if (color!=nil) {
        [self.descriptionLable setTextColor:color];
    }
}

-(void)setPrimaryButtonTextColor:(UIColor*)color{
    if (color!=nil) {
        [self.primaryButton.titleLabel setTextColor:color];
    }
}

-(void)setSecondaryButtonTextColor:(UIColor*)color{
    if (color!=nil) {
        [self.secondaryButton.titleLabel setTextColor:color];
    }
}

-(void)setPrimaryButtonBackgroundColor:(UIColor*)color{
    if (color!=nil) {
        [self.primaryButton setBackgroundColor:color];
    }
}

-(void)setSecondaryButtonBackgroundColor:(UIColor*)color{
    if (color!=nil) {
        [self.secondaryButton setBackgroundColor:color];
    }
}

-(void)setPrimaryButtonBorderColor:(UIColor*)color{
    if (color!=nil) {
        self.primaryButton.layer.borderColor = color.CGColor;
    }
}

-(void)setSecondaryButtonBorderColor:(UIColor*)color{
    if (color!=nil) {
        self.secondaryButton.layer.borderColor = color.CGColor;
    }
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
    
    self.alertView.layer.opacity = 0.5f;
    self.alertView.layer.transform = CATransform3DMakeScale(0.92f, 0.92f, 1.0);
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f];
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

- (void)primaryButtonDidTapped:(UIButton *)button {
    
    if (self.primaryButtonDidTapped != nil) {
        self.primaryButtonDidTapped(self);
    }
    [self dismiss];
}

- (void)secondaryButtonDidTapped:(UIButton *)button {
    
    if (self.secondaryButtonDidTapped != nil) {
        self.secondaryButtonDidTapped(self);
    }
    [self dismiss];
}

@end

@implementation UIRadialView :UIView

- (void)drawRect:(CGRect)rect
{
    // Setup view
    CGFloat colorComponents[] = {0.0, 0.0, 0.0, 1.0,   // First color:  R, G, B, ALPHA (currently opaque black)
        0.0, 0.0, 0.0, 0.0};  // Second color: R, G, B, ALPHA (currently transparent black)
    CGFloat locations[] = {0, 1}; // {0, 1) -> from center to outer edges, {1, 0} -> from outer edges to center
    CGFloat radius = MIN((self.bounds.size.height / 2), (self.bounds.size.width / 2));
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    // Prepare a context and create a color space
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create gradient object from our color space, color components and locations
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, locations, 2);
    
    // Draw a gradient
    CGContextDrawRadialGradient(context, gradient, center, 0.0, center, radius, 0);
    CGContextRestoreGState(context);
    
    // Release objects
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

@end
