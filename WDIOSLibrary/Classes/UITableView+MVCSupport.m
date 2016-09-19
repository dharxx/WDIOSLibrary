//
//  UITableView+MVCSupport.m
//  Weinkeller
//
//  Created by Dhanu Saksrisathaporn on 6/29/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "UITableView+MVCSupport.h"

@implementation UICollectionView (MVCSupport)
- (void)fastRegister:(NSString *)identifier
{
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:identifier];
}
@end

@implementation UITableView (MVCSupport)
- (void)fastRegister:(NSString *)identifier
{
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:identifier];
}
@end
