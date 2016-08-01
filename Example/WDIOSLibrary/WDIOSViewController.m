//
//  WDIOSViewController.m
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 07/28/2016.
//  Copyright (c) 2016 Dhanu Saksrisathaporn. All rights reserved.
//

#import "WDIOSViewController.h"

@import WDIOSLibrary;

@interface WDIOSViewController ()
@property (nonatomic,copy) NSArray<NSString *>*data;
@end

@implementation WDIOSViewController

- (NSArray *)data
{
    if (!_data) {
        self.data = [[NSString languages] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2 options:0];
        }];
    }
    return _data;
}
- (void)refresh
{
    self.data = nil;
    [self.tableView reloadData];
    self.navigationItem.title = [[@"hello" localString] capitalizedString];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [@"Dictionary" setAsTableLanguage];
    [self refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.data[indexPath.row] displayNameOfLocaleID];
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.data[indexPath.row] setAsPreferLanguage];
    [self refresh];
}
@end
