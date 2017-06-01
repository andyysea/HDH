//
//  HotHouseDetailViewController.m
//  HaiDeHui
//
//  Created by junde on 2017/6/1.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HotHouseDetailViewController.h"

/** 屏幕上方图片的高度 */
#define ImageHeight  Width_Screen * 8 / 16

@interface HotHouseDetailViewController ()<UIScrollViewDelegate>

/** 底层添加滚动图片的滚动视图 */
@property (nonatomic, weak) UIScrollView *imageScrollView;
/** 用于添加所有子控件的滚动视图 */
@property (nonatomic, weak) UIScrollView *bgScrollView;
/** 添加最上层的滚动视图,用于控制器底层图片滚动视图的滚动 */
@property (nonatomic, weak) UIScrollView *wrapperScrollView;
/** 显示的公寓名称 */
@property (nonatomic, weak) UILabel *apartmentNameLabel;
/** 当期图片以及总的图片数量 */
@property (nonatomic, weak) UILabel *pictureCountLabel;

@end

@implementation HotHouseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - 设置界面元素
- (void)setupUI {
    self.navItem.title = @"房源详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1> 添加底层盛放图片的滚动视图
    UIScrollView *imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Width_Screen, Height_Screen - 64)];
    imageScrollView.backgroundColor = [UIColor clearColor];
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:imageScrollView];
    
    // 2> 添加底层的滚动视图,用于添加子控件
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Width_Screen, Height_Screen - 64)];
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.delegate = self;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bgScrollView];
    
    // a> 添加滚动视图,用于控制底层图片滚动视图的滚动
    UIScrollView *wrapperScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, ImageHeight)];
    wrapperScrollView.backgroundColor = [UIColor clearColor];
    wrapperScrollView.delegate = self;
    wrapperScrollView.pagingEnabled = YES;
    wrapperScrollView.showsVerticalScrollIndicator = NO;
    wrapperScrollView.showsVerticalScrollIndicator = YES;
    [bgScrollView addSubview:wrapperScrollView];
    
    // b> 添加显示小区名 好 图片当前页数和总页数的视图
    UIView *oneBgView = [[UIView alloc] initWithFrame:CGRectMake(0, ImageHeight - 40, Width_Screen, 40)];
    oneBgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    [wrapperScrollView addSubview:oneBgView];
    // 公寓名标签
    UILabel *apartmentNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, Width_Screen - 80 , 40)];
    apartmentNameLabel.font = [UIFont systemFontOfSize:20];
    apartmentNameLabel.textColor = [UIColor whiteColor];
    apartmentNameLabel.text = @"测试一下";
    [oneBgView addSubview:apartmentNameLabel];
    // 图片页数标签
    UILabel *pictureCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width_Screen - 70, 0, 60 , 40)];
    pictureCountLabel.font = [UIFont systemFontOfSize:20];
    pictureCountLabel.textColor = [UIColor whiteColor];
    pictureCountLabel.textAlignment = NSTextAlignmentCenter;
    pictureCountLabel.text = @"1 / 5";
    [oneBgView addSubview:pictureCountLabel];
    
}



@end
