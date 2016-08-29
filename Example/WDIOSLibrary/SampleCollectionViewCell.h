//
//  SampleCollectionViewCell.h
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 8/25/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleCollectionViewCell : UICollectionViewCell
@property IBOutlet NSLayoutConstraint *imageCenter;
@property IBOutlet NSLayoutConstraint *imageHeight;
@property IBOutlet UIImageView *imageView;
@property IBOutlet UILabel *numberLabel;
- (void)setImage:(UIImage *)image;
- (void)updateCellOriginByView:(UIView *)view;
@end
