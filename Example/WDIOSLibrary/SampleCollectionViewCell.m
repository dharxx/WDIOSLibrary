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
- (void)setImageParallax:(CGFloat)imageParallax
{
    CGFloat diff = self.frame.size.height - self.imageView.frame.size.height;
    CGFloat centerDiff = powf(imageParallax,2) * diff;
    self.imageCenter.constant = centerDiff - (diff * 0.5);
}
@end
