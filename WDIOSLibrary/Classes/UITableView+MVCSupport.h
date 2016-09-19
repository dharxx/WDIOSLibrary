//
//  UITableView+MVCSupport.h
//  Weinkeller
//
//  Created by Dhanu Saksrisathaporn on 6/29/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UICollectionView (MVCSupport)
//nibName = identifier
- (void)fastRegister:(NSString *)identifier;
@end
@interface UITableView (MVCSupport)
//nibName = identifier
- (void)fastRegister:(NSString *)identifier;
@end
