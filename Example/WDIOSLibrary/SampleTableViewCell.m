//
//  SampleTableViewCell.m
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 9/13/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "SampleTableViewCell.h"

@implementation SampleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setImage:(UIImage *)image
{
    if (_imageViewOnCell.image) {
        self.imageViewOnCell.image = image;
        CGRect frame = self.frame;
        self.imageHeight.constant = _imageViewOnCell.image.size.height * ((frame.size.width - 80) / _imageViewOnCell.image.size.width);
        [self layoutIfNeeded];
    }
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (_imageViewOnCell.image) {
        self.imageHeight.constant = _imageViewOnCell.image.size.height * ((frame.size.width - 80) / _imageViewOnCell.image.size.width);
    }
}
-(void)updateCellOriginByView:(UIScrollView *)view
{
    if (!view) {
        self.imageCenter.constant = 0;
        return;
    }
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
    [self layoutIfNeeded];
          
    CGFloat diff = self.frame.size.height - self.imageViewOnCell.frame.size.height;
    CGFloat centerDiff = powf(r,2) * diff;
    self.imageCenter.constant = centerDiff - (diff * 0.5);
}
@end
