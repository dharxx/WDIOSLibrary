//
//  WDIOSTableWaitingView.m
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 9/13/2559 BE.
//
//

#import "WDIOSTableWaitingView.h"

@implementation WDIOSTableWaitingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.autoresizingMask = -1;
        _activityIndicatorView.center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
        [_activityIndicatorView startAnimating];
        [self addSubview:_activityIndicatorView];
    }
    return self;
}

@end
