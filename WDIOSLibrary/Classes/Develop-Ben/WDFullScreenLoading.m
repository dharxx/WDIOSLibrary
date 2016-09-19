//
//  WDFullScreenLoading.m
//  Pods
//
//  Created by BURIN TECHAMA on 8/30/2559 BE.
//
//

#import "WDFullScreenLoading.h"

@implementation WDFullScreenLoading{
    BOOL isShowing;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self baseInit];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self baseInit];
    }
    return self;
}

-(void)baseInit{
    // Initialization code
    isShowing = NO;
    
    [self initView];
}

-(void)initView{
    
    // helpers
    CGSize screenSize = [self screenSize];
    CGFloat screenHeight = screenSize.height;
    CGFloat screenWidth = screenSize.width;
    
    // self
    [self setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self setClipsToBounds:YES];
    [self setBackgroundColor:[UIColor clearColor]];
    
    //add background view
    _backgroundView = [[UIView alloc]init];
    [_backgroundView setBackgroundColor: [UIColor blackColor]];
    [_backgroundView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_backgroundView setAlpha:0.8];
    [self addSubview:_backgroundView];
    
    //addtext
    _loadingText = [[UILabel alloc]init];
    [_loadingText setTextColor:[UIColor whiteColor]];
    [_loadingText setFont:[UIFont boldSystemFontOfSize:14]];
    [_loadingText setText:@"Loading..."];
    [_loadingText setFrame:CGRectMake(0, 0, 100, 100)];
    [_loadingText sizeToFit];
    [_loadingText setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2+40)];
    [self addSubview:_loadingText];
    
    //add indecetor
    _indicator = [[UIActivityIndicatorView alloc]init];
    [_indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_indicator startAnimating];
    [_indicator setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [self addSubview:_indicator];
    
    
}

-(void)show{
    if(!isShowing){
        isShowing = YES;
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
    }
    
}

-(void)hide{
    [self performSelector:@selector(removeFromSuperview) withObject:self];
    isShowing = NO;
}

-(void)setMessage:(NSString *)msg{
    [self.loadingText setText:msg];
    [_loadingText sizeToFit];
    [_loadingText setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2+40)];
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
