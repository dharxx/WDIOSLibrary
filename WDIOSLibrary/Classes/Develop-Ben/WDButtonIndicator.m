//
//  Button+IndicatorView.m
//  Pods
//
//  Created by BURIN TECHAMA on 8/30/2559 BE.
//
//

#import "WDButtonIndicator.h"

@interface WDButtonIndicator()
@property (nonatomic,strong) NSString *buttonTitle;
@end

@implementation WDButtonIndicator{
    BOOL isSpinning;
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

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSArray *subViews = self.subviews;
    [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self initView];
}

-(void)baseInit{
    isSpinning = NO;
    self.buttonTitle = @"Spinner Button";
    // Initialization code
    //[self setBackgroundColor:[UIColor clearColor]];
}

-(void)initView{
    // Initialization view
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:self.buttonTitle forState:UIControlStateNormal];
    [self addSubview:_button];
    [_button setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_button addTarget:self action:@selector(showSpinner) forControlEvents:UIControlEventTouchUpInside];
    
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_indicator setHidesWhenStopped:YES];
    [_indicator setFrame:CGRectMake(0, 0, 30, 30)];
    [self addSubview:_indicator];
    [_indicator setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [_indicator stopAnimating];
}

-(void)setTitle:(NSString *)title{
    [_button setTitle:title forState:UIControlStateNormal];
    self.buttonTitle = title;
}

-(void)showSpinner{
    if (!isSpinning) {
        [_indicator startAnimating];
        [_button setHidden:YES];
        isSpinning = YES;
    }
     
    //auto hide when 5
    [self performSelector:@selector(hideSpinner) withObject:nil afterDelay:5];
}

-(void)hideSpinner{
    [_indicator stopAnimating];
    [_button setHidden:NO];
    isSpinning = NO;
}




@end
