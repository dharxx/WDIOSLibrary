//
//  WDIOSCollectionViewController.h
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 8/5/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHTCollectionViewWaterfallLayout;
@interface WDIOSCollectionViewController : UICollectionViewController
@property (nonatomic) BOOL useFilter;
@property (nonatomic,readonly) UIRefreshControl *refreshControl;
//call completation when done
- (void)loadDataOnSection:(NSInteger)section withRowRange:(NSRange)range completation:(void(^)(NSArray *data))completation;
- (NSInteger)preferNumberOfDatasPerLoad;
//recieve size will resize by width or column again but w:h will be same
- (CGSize)viewSizeByObject:(id)object;
- (void)didSelectObject:(id)object;
- (UICollectionViewCell *)cellByObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)filterData:(NSArray *)data ofSection:(NSInteger)section;
- (BOOL)isSameObject:(id)o1 with:(id)o2 ofSection:(NSInteger)section;
////

- (NSComparisonResult)compareObject:(id)o1 with:(id)o2;
- (CHTCollectionViewWaterfallLayout *)waterfallLayout;
- (UIColor *)activityIndicatorViewLoadMoreColor;
@end
