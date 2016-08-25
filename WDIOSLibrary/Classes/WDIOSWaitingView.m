//
//  WDIOSWaitingView.m
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 8/24/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "WDIOSWaitingView.h"

@implementation WDIOSWaitingView

#pragma mark - Accessors

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicatorView.autoresizingMask = -1;
        _activityIndicatorView.center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
        [_activityIndicatorView startAnimating];
        [self addSubview:_activityIndicatorView];
    }
    return self;
}

@end
