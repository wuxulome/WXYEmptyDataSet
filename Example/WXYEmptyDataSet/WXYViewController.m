//
//  WXYViewController.m
//  WXYEmptyDataSet
//
//  Created by wuxu on 10/21/2015.
//  Copyright (c) 2015 wuxu. All rights reserved.
//

#import "WXYViewController.h"
#import "WXYShowStyleController.h"

@interface WXYViewController ()

@end

@implementation WXYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"WXY";
    
    self.navigationController.navigationBar.titleTextAttributes = nil;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.rowHeight = 70;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.%@", ((long)indexPath.row + 1), [self cellTitleWithIndexPath:indexPath]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WXYShowStyleController *controller = [[WXYShowStyleController alloc] initWithShowStyle:indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - 

- (NSString *)cellTitleWithIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return @"Title Only";
        case 1:
            return @"Title and Detail";
        default:
            return nil;
    }
}

@end
