//
//  HomeViewController.m
//  HaiDeHui
//
//  Created by junde on 2017/5/31.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HomeViewController.h"

/** 分类视图按钮的tag */
#define MyButtonTagOfCategory 10000

/** 可重用标识符 */
static NSString *cellId = @"cellId";

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate>

/** 表格视图 */
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - 下拉刷新数据
- (void)loadPulldownRefresh {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark - 分类视图按钮的点击方法
- (void)categoryViewButtonClick:(UIButton *)button {
    NSInteger tag = button.tag - MyButtonTagOfCategory;
    switch (tag) {
        case 0: // 最热房源
            
            break;
        case 1: // 海外项目
            
            break;
        default: // 我的客服
            
            break;
            
    }
}



#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"当前轮播的页数 --> %zd", index);
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 30)];
    UILabel *recommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width_Screen - 15, 30)];
    recommendLabel.text = @"精品房源推荐";
    [bgView addSubview:recommendLabel];
    return bgView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    
    
    return cell;
}



#pragma mark - 设置界面元素
- (void)setupUI {
    self.navItem.title = @"首页";
    // 1>添加表格视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Width_Screen, Height_Screen - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.separatorColor = [UIColor lightGrayColor];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:tableView];
    
    // 2>添加headerView作为表格视图的表头视图,包含轮播图,三个分类
    // 根据不同手机屏幕适当缩放轮播图的宽高,避免7p上显得轮播图拉的过长,屏幕宽高比 9 / 16 但是以此比例轮播图太大
    CGFloat headerViewHeight = Width_Screen * 210 / 320;
    CGFloat cycleViewHeight = Width_Screen * 140 / 320;
    CGFloat categoryViewHeight = Width_Screen * 70 / 320;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, headerViewHeight)];
    headerView.backgroundColor = [UIColor orangeColor];
    tableView.tableHeaderView = headerView;
    
    // a> 添加轮播图
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Width_Screen, cycleViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleView.autoScrollTimeInterval = 3.0f;
    [headerView addSubview:cycleView];
    
    // b> 添加广播
    
    // c> 添加分类视图
    UIView *categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, cycleViewHeight, Width_Screen, categoryViewHeight)];
    categoryView.backgroundColor = [UIColor orangeColor];
    [headerView addSubview:categoryView];
    
    CGFloat margin = (Width_Screen - categoryViewHeight * 3) / 4;
    CGFloat scale = 0.6;
    CGRect rect = CGRectMake(margin, 0, categoryViewHeight, categoryViewHeight);
    
    NSArray *buttonTitles = @[@"最热房源",@"海外项目",@"我的客服"];
    NSArray *buttonImageNames = @[@"one",@"two",@"three"];
    for (NSInteger i = 0; i < buttonTitles.count; i++) {
        NSString *title = buttonTitles[i];
        UIImage *image = [UIImage imageNamed:buttonImageNames[i]];
        NSAttributedString *attr = [NSAttributedString yh_imageTextWithImage:image imageWH:categoryViewHeight * scale title:title fontSize:15 titleColor:[UIColor blackColor] spacing:4];
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectOffset(rect, (margin + categoryViewHeight) * i, 0);
        [button setAttributedTitle:attr forState:UIControlStateNormal];
        button.titleLabel.numberOfLines = 0;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [categoryView addSubview:button];
        
        button.tag = MyButtonTagOfCategory + i;
        [button addTarget:self action:@selector(categoryViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 3> 添加下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadPulldownRefresh)];
    [tableView.mj_header beginRefreshing];
    
    // 4> 属性记录
    _tableView = tableView;
}




@end
