//
//  WDIOSTableViewController.h
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 9/13/2559 BE.
//
//

#import <UIKit/UIKit.h>

@interface WDIOSTableViewController : UITableViewController
@property (nonatomic) BOOL useFilter;
//call completation when done
- (void)loadDataOnSection:(NSInteger)section withRowRange:(NSRange)range completation:(void(^)(NSArray *data))completation;
- (NSInteger)preferNumberOfDatasPerLoad;
//recieve size will resize by width or column again but w:h will be same
- (CGFloat)viewHeightByObject:(id)object;
- (void)didSelectObject:(id)object;
- (UITableViewCell *)cellByObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)filterData:(NSArray *)data ofSection:(NSInteger)section;
- (BOOL)isSameObject:(id)o1 with:(id)o2 ofSection:(NSInteger)section;
////

- (NSComparisonResult)compareObject:(id)o1 with:(id)o2;
- (UIColor *)activityIndicatorViewLoadMoreColor;
- (void)setInitialDatas:(NSArray *)datas;
- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation;

- (void)startRefresh:(id)sender;
@end
