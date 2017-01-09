//
//  WDIOSTableViewController.m
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 9/13/2559 BE.
//
//

#import "WDIOSTableViewController.h"
#import "WDIOSTableWaitingView.h"
#import "NSObject+MVCSupport.h"

@interface WDIOSTableViewController ()
@property (nonatomic) BOOL loading;
@property (nonatomic,retain) NSMutableArray<NSMutableArray *>*datas;
@property BOOL doneLoad;
@end

@implementation WDIOSTableViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
        [self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height) animated:YES];
    });
    self.loading = YES;
    self.tableView.sectionFooterHeight = 0;
    
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
- (NSDictionary *)refreshControlTitleAttribute
{
    return nil;
}
- (void)endRefresh:(id)sender
{
    //    [self.collectionView reloadData];
    //    [self.collectionView layoutIfNeeded];
    //    [self.refreshControl endRefreshing];
    dispatch_async(dispatch_get_main_queue(), ^{
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self.tableView reloadData];
            NSString *stringDate = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
            NSString *lastUpdate = [NSString stringWithFormat:@"Last updated on %@", stringDate];
            NSDictionary *attribute = [self refreshControlTitleAttribute];
            if (!attribute) {
                self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdate];
            }
            else {
                self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdate attributes:attribute];
            }
        }];
        [self.tableView setContentOffset:CGPointZero animated:YES];
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
        self.tableView.alwaysBounceVertical = YES;
        self.tableView.sectionFooterHeight = 0;
        [self.tableView reloadData];
    });
}
- (void)loadMore:(id)sender
{
    if (!self.loading) {
        self.loading = YES;
        self.tableView.sectionFooterHeight = 60;
        self.tableView.alwaysBounceVertical = NO;
        //add loadmore cell
        
        NSInteger section  = self.lastSectionIndex;
        NSInteger location;
        if (section < 0) {
            self.datas = [NSMutableArray arrayWithCapacity:10];
            [self.datas addObject:[NSMutableArray arrayWithCapacity:10]];
            section = 0;
            location = 0;
            [self.tableView reloadData];
        }else {
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
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
- (CGFloat)viewHeightByObject:(id)object
{
    NSLog(@"implement %@ for height of%@",__func__,object);
    return 0;
}
- (void)didSelectObject:(id)object
{
    NSLog(@"%@",object);
}
- (NSInteger)preferNumberOfDatasPerLoad
{
    return 10;
}
- (UITableViewCell *)cellByObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (void)loadDataOnSection:(NSInteger)section withRowRange:(NSRange)range completation:(void(^)(NSArray *data))completation;
{
    completation(nil);
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
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(startRefresh:)
              forControlEvents:UIControlEventValueChanged];
    self.tableView.alwaysBounceVertical = YES;
//    [self.tableView registerClass:[WDIOSTableWaitingView class]  forHeaderFooterViewReuseIdentifier:@"WDIOSTableWaitingView"];
    self.loading = NO;
    self.tableView.sectionFooterHeight = 0;

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_datas.count == 0) {
        [self loadMore:nil];
    }
    else {
        
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
    //nothing to do yet
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_doneLoad && !_loading && indexPath.section == self.lastSectionIndex && indexPath.row == self.lastRowIndex) {
        [self loadMore:cell];
    }
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
#pragma mark <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger n = MAX(1,self.datas.count);
    return n;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n = self.datas.count == 0 ? 0: self.datas[section].count;
    return n;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    WDIOSTableWaitingView *v = [[WDIOSTableWaitingView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];//[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WDIOSTableWaitingView"];
    UIColor *c  = [self activityIndicatorViewLoadMoreColor];
    if (c) {
        v.activityIndicatorView.color = c;
    }
    return v;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self objectByIndexPath:indexPath];
    UITableViewCell *cell = [self cellByObject:object atIndexPath:indexPath];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self objectByIndexPath:indexPath];
    return [self viewHeightByObject:object];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [self objectByIndexPath:indexPath];
    if (obj) {
        [self didSelectObject:obj];
    }
}
- (UIColor *)activityIndicatorViewLoadMoreColor
{
    return nil;
}
@end
