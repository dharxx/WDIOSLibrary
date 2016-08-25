//
//  ExampleCollectionViewController.m
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 8/24/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "ExampleCollectionViewController.h"
#import <ImageIO/ImageIO.h>
#import "SampleCollectionViewCell.h"

@import WDIOSLibrary;
@interface ExampleCollectionViewController ()
@property (nonatomic,retain) NSMutableArray<NSString *> *images;
@end


@implementation ExampleCollectionViewController
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

    // Do any additional setup after loading the view.
}

- (NSInteger)preferNumberOfDatasPerLoad
{
    return 20;
}
- (void)loadDataOnSection:(NSInteger)section withRowRange:(NSRange)range completation:(void(^)(NSArray *data))completation;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [NSThread sleepForTimeInterval:3];
        if (section == 0) {
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:range.length];
            //
            for (int i = range.location; i < range.location + range.length; i++) {
                [data addObject:self.images[i%self.images.count]];
            }
            //
            completation(data);
        }
        else {
            completation(nil);
        }
    });
    
}
- (UICollectionViewCell *)cellByObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    SampleCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    // Configure the cell
    [cell setImage:[UIImage imageNamed:object]];
    return cell;
}


- (BOOL)isSameObject:(id)o1 with:(id)o2 ofSection:(NSInteger)section
{
    return [o1 isEqual:o2];
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    [self settingCellLabel:(SampleCollectionViewCell *)cell];
}
- (void)settingCellLabel:(SampleCollectionViewCell *)cell
{
    //    NSIndexPath *idPath = [self.collectionView indexPathForCell:cell];
    //    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:idPath];
    CGRect cellRect = cell.frame;//attributes.frame;
    UIView *superview = [self.collectionView superview];
    CGRect cellFrameInSuperview = [self.collectionView convertRect:cellRect toView:superview];
    CGFloat h = superview.frame.size.height - cellFrameInSuperview.size.height;
    CGFloat y = cellFrameInSuperview.origin.y;
    CGFloat r = y / h;
    
    if (r < 0) {
        r = 0;
    }
    else if (r > 1) {
        r = 1;
    }
    [cell setImageParallax:r];
//    cell.numberLabel.text = @(r).stringValue;
}
- (CGSize)viewSizeByObject:(id)object
{
    NSString *path = [[NSBundle mainBundle] pathForResource:object ofType:nil];
    CGSize size = [UIImage imageSize:path];
    if (size.height > size.width) {
        size.height = size.width;
    }
    return size;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray<UICollectionViewCell *> *cells = self.collectionView.visibleCells;
    for (SampleCollectionViewCell *cell in cells) {
        [self settingCellLabel:cell];
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

@end
