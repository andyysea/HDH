//
//  HomeViewController.m
//  HaiDeHui
//
//  Created by junde on 2017/5/31.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h" 
#import "HotHouseListViewController.h" // 最热房源列表


/** 分类视图按钮的tag */
#define MyButtonTagOfCategory 10000
/** 可重用标识符 */
static NSString *cellId = @"cellId";

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate>

/** 表格视图 */
@property (nonatomic, weak) UITableView *tableView;
/** 轮播图属性 */
@property (nonatomic, weak) SDCycleScrollView *cycleView;
/** 小广播 */
@property (nonatomic, weak) UILabel *broadcastLabel;

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
- (void)categoryViewButtonClick:(UIControl *)button {
    NSInteger tag = button.tag - MyButtonTagOfCategory;
    switch (tag) {
        case 0: // 最热房源
            [self.navigationController pushViewController:[HotHouseListViewController new] animated:YES];
            break;
        case 1: // 海外项目
            NSLog(@"1");

            break;
            
        case 2: // 我的客服
            NSLog(@"2");
            
            break;
        default:// 广播小喇叭
            NSLog(@"default");
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
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
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    
    
    return cell;
}



#pragma mark - 设置界面元素
- (void)setupUI {
    self.navItem.title = @"首页";
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 1>添加表格视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Width_Screen, Height_Screen - 64 - 49) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.separatorColor = [UIColor lightGrayColor];
    [tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:tableView];
    
    // 2>添加headerView作为表格视图的表头视图,包含轮播图,三个分类
    // 根据不同手机屏幕适当缩放轮播图的宽高,避免7p上显得轮播图拉的过长,屏幕宽高比 9 / 16 但是以此比例轮播图太大
    CGFloat headerViewHeight = Width_Screen * 210 / 320 + 30;
    CGFloat cycleViewHeight = Width_Screen * 140 / 320;
    CGFloat categoryViewHeight = Width_Screen * 70 / 320 + 30;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, headerViewHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    tableView.tableHeaderView = headerView;
    
    // a> 添加轮播图
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Width_Screen, cycleViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleView.autoScrollTimeInterval = 3.0f;
    [headerView addSubview:cycleView];
    
    // b> 添加广播视图 和 分类视图
    UIView *categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, cycleViewHeight, Width_Screen, categoryViewHeight)];
    categoryView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:categoryView];

    // 添加广播视图
    UIControl *broadcastControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 30)];
    broadcastControl.backgroundColor = [UIColor whiteColor];
    [categoryView addSubview:broadcastControl];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 15, 15)];
    imageView.image = [UIImage imageNamed:@"小喇叭"];
    [broadcastControl addSubview:imageView];
    
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(35, 0, 1, 29)];
    verticalLine.backgroundColor = [UIColor lightGrayColor];
    [broadcastControl addSubview:verticalLine];
    
    UILabel *broadcastLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, Width_Screen - 45, 29)];
    broadcastLabel.font = [UIFont systemFontOfSize:14];
    broadcastLabel.text = @"测试";
    [broadcastControl addSubview:broadcastLabel];
    
    UIView *horizontalLIne = [[UIView alloc] initWithFrame:CGRectMake(0, 29, Width_Screen, 1)];
    horizontalLIne.backgroundColor = [UIColor lightGrayColor];
    [broadcastControl addSubview:horizontalLIne];
    
    [broadcastControl addTarget:self action:@selector(categoryViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加分类视图
    CGFloat margin = (Width_Screen - (categoryViewHeight - 30) * 3) / 4;
    CGFloat scale = 0.6;
    CGRect rect = CGRectMake(margin, 30, categoryViewHeight - 30, categoryViewHeight - 30);
    
    NSArray *buttonTitles = @[@"最热房源",@"海外项目",@"我的客服"];
    NSArray *buttonImageNames = @[@"one",@"two",@"three"];
    for (NSInteger i = 0; i < buttonTitles.count; i++) {
        NSString *title = buttonTitles[i];
        UIImage *image = [UIImage imageNamed:buttonImageNames[i]];
        NSAttributedString *attr = [NSAttributedString yh_imageTextWithImage:image imageWH:(categoryViewHeight - 30) * scale title:title fontSize:15 titleColor:[UIColor blackColor] spacing:4];
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectOffset(rect, (margin + (categoryViewHeight - 30)) * i, 0);
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
    _cycleView = cycleView;
    _broadcastLabel = broadcastLabel;
}




@end
