//
//  SampleCollectionViewCell.m
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 8/25/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "SampleCollectionViewCell.h"

@implementation SampleCollectionViewCell

- (void)setImage:(UIImage *)image
{
    if (_imageView.image) {
        self.imageView.image = image;
        CGRect frame = self.frame;
        self.imageHeight.constant = _imageView.image.size.height * (frame.size.width / _imageView.image.size.width);
        [self layoutIfNeeded];
    }
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (_imageView.image) {
        self.imageHeight.constant = _imageView.image.size.height * (frame.size.width / _imageView.image.size.width);
    }
}
-(void)updateCellOriginByView:(UIView *)view
{
    CGRect cellRect = self.frame;//attributes.frame;
    CGRect cellFrameInSuperview = [view convertRect:cellRect toView:view.superview];
    CGFloat h = view.superview.frame.size.height - cellFrameInSuperview.size.height;
    CGFloat y = cellFrameInSuperview.origin.y;
    CGFloat r = y / h;
    if (r < 0) {
        r = 0;
    }
    else if (r > 1) {
        r = 1;
    }
    CGFloat diff = self.frame.size.height - self.imageView.frame.size.height;
    CGFloat centerDiff = powf(r,2) * diff;
    self.imageCenter.constant = centerDiff - (diff * 0.5);
}
@end
