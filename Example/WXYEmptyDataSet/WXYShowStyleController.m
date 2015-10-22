//
//  WXYShowStyleController.m
//  WXYEmptyDataSet
//
//  Created by Lome on 15/10/22.
//  Copyright © 2015年 吴旭. All rights reserved.
//

#import "WXYShowStyleController.h"
#import "UIScrollView+WXYEmptyDataSet.h"

@interface WXYShowStyleController ()
@property (nonatomic, assign) NSInteger showStyle;
@end

@implementation WXYShowStyleController

- (instancetype)initWithShowStyle:(NSInteger)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.showStyle = style;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showEmptyDataSet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)showEmptyDataSet
{
    switch (self.showStyle) {
        case 0:
            [self.tableView wxy_setEmptyWithTitle:@"Hello World"];
            break;
        case 1:
            self.tableView.wxy_wholeVerticalOffset = -200;
            self.tableView.wxy_wholeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
            self.tableView.wxy_titleToDetailSpacing = 10;
            [self.tableView wxy_setEmptyWithTitle:@"Hello World" detail:@"Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state"];
            break;
        default:
            break;
    }
}

@end
