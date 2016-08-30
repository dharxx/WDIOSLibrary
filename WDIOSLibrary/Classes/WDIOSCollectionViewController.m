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
    
//    for (id object in data.reverseObjectEnumerator) {
//        if (sectionArray.count == 0) {
//            break;
//        }
//        else if ([self isSameObject:object with:[sectionArray lastObject] ofSection:section]) {
//            NSLog(@"%@",sectionArray.lastObject);
//            [sectionArray removeLastObject];
//        }
//    }
    [sectionArray addObjectsFromArray:data];
}
- (void)startRefresh:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.refreshControl beginRefreshing];
         [self.collectionView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height) animated:YES];
    });
    self.loading = YES;
    
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
        }];
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
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}
- (void)loadMore:(id)sender
{
    if (!self.loading) {
        self.loading = YES;
        //add loadmore cell
        
        NSInteger section  = self.lastSectionIndex;
        
        if (section < 0) {
            self.datas = [NSMutableArray arrayWithCapacity:10];
            section = 0;
        }
        else {
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:[self lastSectionIndex]]];
        }
        
        NSRange range = NSMakeRange(section, self.preferNumberOfDatasPerLoad);
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionView *cv = self.collectionView;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(startRefresh:)
              forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:_refreshControl atIndex:0];
    self.collectionView.alwaysBounceVertical = YES;
    
    self.loading = NO;
    
    CHTCollectionViewWaterfallLayout *layout = (CHTCollectionViewWaterfallLayout *)self.collectionViewLayout;
    layout.footerHeight = 44;
//    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"org.cocoapods.WDIOSLibrary"];
//    NSLog(@"%@",bundle.bundlePath);
//    NSLog(@"nib %@",[self recursivePathsForResourcesOfType:@"nib" inDirectory:bundle.bundlePath]);
//        NSLog(@"bundle %@",[self recursivePathsForResourcesOfType:@"bundle" inDirectory:bundle.bundlePath]);
//    UINib *nib = [UINib nibWithNibName:@"WDIOSWaitingView" bundle:bundle];
//    
//    [self.collectionView registerNib:nib forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:@"WDIOSWaitingView"];
    [self.collectionView registerClass:[WDIOSWaitingView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:@"WDIOSWaitingView"];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
//    [self startRefresh:nil];
    
    [self loadMore:nil];
    
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_doneLoad && indexPath.section == self.lastSectionIndex && indexPath.row == self.lastRowIndex) {
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
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
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
    return MAX(1,self.datas.count);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.datas.count == 0 ? 0: self.datas[section].count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *v =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"WDIOSWaitingView" forIndexPath:indexPath];
    return v;
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
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (!_doneLoad && _loading && section == [self lastSectionIndex] ) {
        CHTCollectionViewWaterfallLayout *fLayout = (id)collectionViewLayout;
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), fLayout.footerHeight);
    }
    return CGSizeZero;
}
- (CHTCollectionViewWaterfallLayout *)waterfallLayout
{
    return (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
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

@end
