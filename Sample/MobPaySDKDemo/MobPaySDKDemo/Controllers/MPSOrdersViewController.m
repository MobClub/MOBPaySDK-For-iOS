//
//  MPSOrdersViewController.m
//  MobPaySDKDemo
//
//  Created by youzu_Max on 2017/9/12.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import "MPSOrdersViewController.h"
#import "MPSOrdersTableViewCell.h"
#import "MPSOrder.h"
#import <MOBFoundation/MOBFoundation.h>

@interface MPSOrdersViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *ordersTableView;
@property (nonatomic, strong) NSMutableArray *orders;

@end

static NSString *const kMPSOrderCellReuseIdentifier = @"MPSOrdersTableViewCellReuseIdentifier";

@implementation MPSOrdersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的订单";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftBarButtonItem];
    
    _ordersTableView.rowHeight = 146;
    [_ordersTableView registerNib:[UINib nibWithNibName:@"MPSOrdersTableViewCell" bundle:nil] forCellReuseIdentifier:kMPSOrderCellReuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.orders = nil;
    [self.ordersTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPSOrdersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMPSOrderCellReuseIdentifier];
    
    cell.order = self.orders[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

#pragma mark - getter

- (NSArray *)orders
{
    if (!_orders)
    {
        NSArray *cachedData = [[MOBFDataService sharedInstance] cacheDataForKey:@"MPSDemo_orders" domain:@"MPSDemo"];
        
        if ([cachedData isKindOfClass:NSArray.class])
        {
            _orders = cachedData.mutableCopy;
        }
    }
    
    return _orders;
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
