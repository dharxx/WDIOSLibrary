//
//  WDIOSCollectionViewController.m
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 8/5/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "WDIOSCollectionViewController.h"
#import "WDIOSCollectionViewLayout.h"
#import "WDIOSWaitingView.h"
#import "NSObject+MVCSupport.h"
@interface WDIOSCollectionViewController ()<CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic,retain) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL loading;
@property (nonatomic,retain) NSMutableArray<NSMutableArray *>*datas;
@property BOOL doneLoad;
@end

@implementation WDIOSCollectionViewController

- (NSInteger)lastSectionIndex
{
    return _datas.count - 1;
}
- (NSInteger)lastRowIndex
{
    return _datas[self.lastSectionIndex].count - 1;
}
- (id)lastObject
{
    if (self.datas.count > 0 && self.datas.lastObject.count > 0)
    {
        return self.datas.lastObject.lastObject;
    }
    return nil;
}
- (NSComparisonResult)compareObject:(id)o1 with:(id)o2
{
    return NSOrderedSame;
}
- (BOOL)isSameObject:(id)o1 with:(id)o2 ofSection:(NSInteger)section
{
    return [o1 isEqual:o2];
}
- (NSArray *)filterData:(NSArray *)data ofSection:(NSInteger)section
{
    return data;
}
- (void)mergingData:(NSArray *)data section:(NSInteger)section
{
    //find same data
    NSMutableArray *sectionArray = nil;
    if (self.datas.count <= section) {
        sectionArray = [NSMutableArray arrayWithCapacity:10];
        [self.datas addObject:sectionArray];
    }
    else {
        sectionArray = self.datas[section];
    }
    
    [sectionArray addObjectsFromArray:data];
}
- (void)startRefresh:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.refreshControl beginRefreshing];
         [self.collectionView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height) animated:YES];
    });
    self.loading = YES;
    self.waterfallLayout.footerHeight = 0;
    
    NSRange range = NSMakeRange(0, self.preferNumberOfDatasPerLoad);
    [self loadDataOnSection:0
               withRowRange:range
               completation:^(NSArray *data) {
                   //merging refresh data
                   _doneLoad = NO;
                   self.datas = [NSMutableArray arrayWithCapacity:10];
                   [self mergingData:data section:0];
                   self.loading = NO;
                   [self endRefresh:sender];
               }];
}
- (void)endRefresh:(id)sender
{
//    [self.collectionView reloadData];
//    [self.collectionView layoutIfNeeded];
    //    [self.refreshControl endRefreshing];
    dispatch_async(dispatch_get_main_queue(), ^{
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self.collectionView reloadData];
            NSString *stringDate = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
            NSString *lastUpdate = [NSString stringWithFormat:@"Last updated on %@", stringDate];
            self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdate];
        }];
        [self.collectionView setContentOffset:CGPointZero animated:YES];
        [self.refreshControl endRefreshing];
        [CATransaction commit];
//        [UIView animateWithDuration:0.1 animations:^{
//            [self.refreshControl endRefreshing];
//            self.collectionView.alpha = 0;
//        } completion:^(BOOL finished) {
//            [self.collectionView reloadData];
//            [UIView animateWithDuration:0.3 animations:^{
//                self.collectionView.alpha = 1;
//            } completion:^(BOOL finished) {
//            }];
//        }];
    });
}
- (void)doneLoad:(id)sender
{
    //remove loadmore cell
    self.loading = NO;
    wdios_mainBlock(^{
        self.collectionView.alwaysBounceVertical = YES;
        self.waterfallLayout.footerHeight = 0;
        [self.collectionView reloadData];
    });
}
- (void)loadMore:(id)sender
{
    if (!self.loading) {
        self.loading = YES;
        self.waterfallLayout.footerHeight = 60;
        self.collectionView.alwaysBounceVertical = NO;
        //add loadmore cell
        
        NSInteger section  = self.lastSectionIndex;
        NSInteger location;
        if (section < 0) {
            self.datas = [NSMutableArray arrayWithCapacity:10];
            [self.datas addObject:[NSMutableArray arrayWithCapacity:10]];
            section = 0;
            location = 0;
            [self.collectionView reloadData];
        }else {
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
            location = self.datas[section].count;
        }
        
        NSRange range = NSMakeRange(location, self.preferNumberOfDatasPerLoad);
        [self loadDataOnSection:section
                   withRowRange:range
                   completation:^(NSArray *data) {
                       //merging refresh data
                       if (data.count == 0) {
                           NSInteger nsection = section + 1;
                           NSRange nrange = NSMakeRange(0, self.preferNumberOfDatasPerLoad);
                           [self loadDataOnSection:nsection
                                      withRowRange:nrange
                                      completation:^(NSArray *data) {
                                          if (data.count == 0) {
                                              _doneLoad = YES;
                                              [self doneLoad:sender];
                                          }
                                          else {
                                              [self mergingData:data section:nsection];
                                              [self doneLoad:sender];
                                          }
                                      }];
                       }
                       else {
                           [self mergingData:data section:section];
                           [self doneLoad:sender];
                       }
                   }];
    }
}
- (CGSize)viewSizeByObject:(id)object
{
    return CGSizeZero;
}
- (void)didSelectObject:(id)object
{
    NSLog(@"%@",object);
}
- (NSInteger)preferNumberOfDatasPerLoad
{
    return 10;
}
- (UICollectionViewCell *)cellByObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (void)loadDataOnSection:(NSInteger)section withRowRange:(NSRange)range completation:(void(^)(NSArray *data))completation;
{
    completation(nil);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (NSArray *)recursivePathsForResourcesOfType:(NSString *)type inDirectory:(NSString *)directoryPath{
    
    NSMutableArray *filePaths = [[NSMutableArray alloc] init];
    
    // Enumerators are recursive
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:directoryPath];
    
    NSString *filePath;
    
    while ((filePath = [enumerator nextObject]) != nil){
        
        // If we have the right type of file, add it to the list
        // Make sure to prepend the directory path
        if([[filePath pathExtension] isEqualToString:type]){
            [filePaths addObject:[directoryPath stringByAppendingPathComponent:filePath]];
        }
    }
    
    
    return filePaths;
}
- (void)setInitialDatas:(NSArray *)datas
{
    self.datas = datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionView *cv = self.collectionView;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(startRefresh:)
              forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:_refreshControl atIndex:0];
    self.collectionView.alwaysBounceVertical = YES;
    
    [self.collectionView registerClass:[WDIOSWaitingView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:@"WDIOSWaitingView"];
    self.loading = NO;
    self.waterfallLayout.footerHeight = 0;
    if (_datas.count == 0) {
        [self loadMore:nil];
    }
    else {
        
    }
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_doneLoad && !_loading && indexPath.section == self.lastSectionIndex && indexPath.row == self.lastRowIndex) {
        [self loadMore:cell];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    WDIOSCollectionViewLayout *layout = [self waterfallLayout];
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (id)objectByIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= self.datas.count || indexPath.row >= self.datas[indexPath.section].count) {
        NSLog(@"THIS IS A BUG\n%@ %@\n%@",@(indexPath.section),@(indexPath.row),self.datas);
        return nil;
    }
    return self.datas[indexPath.section][indexPath.row];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger n = MAX(1,self.datas.count);
    return n;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger n = self.datas.count == 0 ? 0: self.datas[section].count;
    return n;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        WDIOSWaitingView *v =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"WDIOSWaitingView" forIndexPath:indexPath];
        UIColor *c  = [self activityIndicatorViewLoadMoreColor];
        if (c) {
            v.activityIndicatorView.color = c;
        }
        return v;
    }
    return nil;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self objectByIndexPath:indexPath];
    UICollectionViewCell *cell = [self cellByObject:object atIndexPath:indexPath];
    return cell;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self objectByIndexPath:indexPath];
    return [self viewSizeByObject:object];
}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section
//{
//    if (!_doneLoad && _loading && section >= [self lastSectionIndex] ) {
//        WDIOSCollectionViewLayout *fLayout = (id)collectionViewLayout;
//        CGSize size = CGSizeMake(CGRectGetWidth(collectionView.bounds), fLayout.footerHeight);
//        NSLog(@"%@",NSStringFromCGSize(size));
//        return size;
//    }
//    return CGSizeZero;
//}
- (WDIOSCollectionViewLayout *)waterfallLayout
{
    return (WDIOSCollectionViewLayout *)self.collectionView.collectionViewLayout;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [self objectByIndexPath:indexPath];
    if (obj) {
        [self didSelectObject:obj];
    }
}
//#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

- (UIColor *)activityIndicatorViewLoadMoreColor
{
    return nil;
}
@end
