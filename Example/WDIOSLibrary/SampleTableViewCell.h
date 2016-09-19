//
//  SampleTableViewCell.h
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 9/13/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleTableViewCell : UITableViewCell
@property IBOutlet NSLayoutConstraint *imageCenter;
@property IBOutlet NSLayoutConstraint *imageHeight;
@property IBOutlet UIImageView *imageViewOnCell;
@property IBOutlet UILabel *numberLabel;
- (void)setImage:(UIImage *)image;
- (void)updateCellOriginByView:(UIView *)view;
@end
