//
//  UIView+MVCSupport.m
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 8/30/2559 BE.
//
//

#import "UIView+MVCSupport.h"

@implementation UIView (MVCSupport)
- (void)setModelObject:(id)object {
    
}
- (id)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        id responder = [subView findFirstResponder];
        if (responder){
            return responder;
        }
    }
    return nil;
}
- (void)removeAllSubviews
{
    for (UIView *v in self.subviews.copy) {
        [v removeFromSuperview];
    }
}
@end
