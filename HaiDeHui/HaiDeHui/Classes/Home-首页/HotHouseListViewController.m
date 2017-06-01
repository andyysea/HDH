//
//  HotHouseListViewController.m
//  HaiDeHui
//
//  Created by junde on 2017/6/1.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HotHouseListViewController.h"
#import "HotHouseListTableViewCell.h"
#import "HotHouseDetailViewController.h"

/** 可重用标识符 */
static NSString *hotCellId = @"hotCellId";

@interface HotHouseListViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation HotHouseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HotHouseDetailViewController *detailVC = [HotHouseDetailViewController new];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotHouseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hotCellId forIndexPath:indexPath];
    

    
    return cell;
}


#pragma mark - 设置界面元素
- (void)setupUI {
    self.navItem.title = @"最热房源";
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    // 1>添加表格视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Width_Screen, Height_Screen - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.separatorColor = [UIColor lightGrayColor];
    [tableView registerClass:[HotHouseListTableViewCell class] forCellReuseIdentifier:hotCellId];
    [self.view addSubview:tableView];

    
}



@end
