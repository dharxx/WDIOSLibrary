//
//  ExampleTableViewController.m
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 9/13/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "ExampleTableViewController.h"
#import "SampleTableViewCell.h"

@interface ExampleTableViewController ()
@property (nonatomic,retain) NSMutableArray<NSString *> *images;
@property (nonatomic) void (^cmp)(NSArray *data);
@end

@implementation ExampleTableViewController

- (NSMutableArray<NSString *> *)images
{
    if (!_images) {
        self.images = [NSMutableArray arrayWithCapacity:9];
        for (int i = 0; i < 9; i++) {
            _images[i] = [@(i + 1).stringValue stringByAppendingPathExtension:@"jpg"];
        }
    }
    return _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.

}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}
- (NSInteger)preferNumberOfDatasPerLoad
{
    return 20;
}

- (void)completation:(NSValue *)range;
{
    static NSInteger max = 60;
    NSRange r = range.rangeValue;
    if(r.location > max )
    {
        self.cmp(nil);
    }
    else {
        NSMutableArray *data = [NSMutableArray arrayWithCapacity:10];
        for (NSInteger i = r.location; i < r.location + r.length && i < max; i++) {
            [data addObject:self.images[i%self.images.count]];
        }
        self.cmp(data);
    }
}
- (void)loadDataOnSection:(NSInteger)section withRowRange:(NSRange)range completation:(void(^)(NSArray *data))completation;
{
    if (section == 0) {
        self.cmp = completation;
        [self performSelector:@selector(completation:) withObject:[NSValue valueWithRange:range] afterDelay:3];
    }
    else {
        completation(nil);
    }
}
- (UITableViewCell *)cellByObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    SampleTableViewCell *cell = (id)[self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    // Configure the cell
    [cell setImage:[UIImage imageNamed:object]];
    cell.numberLabel.text = @(indexPath.row).stringValue;
    return cell;
}


- (BOOL)isSameObject:(id)o1 with:(id)o2 ofSection:(NSInteger)section
{
    return [o1 isEqual:o2];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    [(SampleTableViewCell *)cell updateCellOriginByView:tableView];
}
-(CGFloat)viewHeightByObject:(id)object
{
    return 144;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray<SampleTableViewCell *> *cells = self.tableView.visibleCells;
    for (SampleTableViewCell *cell in cells) {
        [(SampleTableViewCell *)cell updateCellOriginByView:self.tableView];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
- (UIColor *)activityIndicatorViewLoadMoreColor
{
    return [UIColor blueColor];
}

@end
