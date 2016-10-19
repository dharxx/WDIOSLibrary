//
//  UIView+MVCSupport.h
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 8/30/2559 BE.
//
//

#import <UIKit/UIKit.h>

@interface UIView (MVCSupport)
- (void)setModelObject:(id)object;
- (id)findFirstResponder;
- (void)removeAllSubviews;
@end
