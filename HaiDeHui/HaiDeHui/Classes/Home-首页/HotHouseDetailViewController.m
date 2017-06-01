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



/**
 测试数组
 */
@property (nonatomic, strong) NSArray *imageArray;


@end

@implementation HotHouseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}

#pragma mark - 点按手势,用于弹出图片浏览器
- (void)tapGestureClick {
    NSLog(@"要弹出图片浏览器,并且获取当前的第几张图片");
}

#pragma mark - 加载数据
- (void)loadData {
    _imageArray =  @[
                     @"http://ww2.sinaimg.cn/thumbnail/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                                          @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
                     @"http://ww4.sinaimg.cn/thumbnail/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg",
                     @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                     @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                     @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                     @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                     @"http://ww2.sinaimg.cn/thumbnail/677febf5gw1erma104rhyj20k03dz16y.jpg",
                     @"http://ww4.sinaimg.cn/thumbnail/677febf5gw1erma1g5xd0j20k0esa7wj.jpg"
                     ];
    // 请求完毕数据之后,设置图片
    NSInteger index = 0;
    for (NSString *urlStr in _imageArray) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index * Width_Screen, 0, Width_Screen, ImageHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"hehe"]];
        imageView.tag = index;
        index++;
        [self.imageScrollView addSubview:imageView];
    }
    self.imageScrollView.contentSize = CGSizeMake(_imageArray.count * Width_Screen, ImageHeight);
    self.wrapperScrollView.contentSize = CGSizeMake(_imageArray.count * Width_Screen, ImageHeight);
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
    wrapperScrollView.showsVerticalScrollIndicator = NO;
    [bgScrollView addSubview:wrapperScrollView];
    
    // 添加一个点按手势,用于控制点击上面图片部分弹出图片浏览器
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClick)];
    [wrapperScrollView addGestureRecognizer:tapGesture];
    
    // b> 添加显示小区名 好 图片当前页数和总页数的视图
    UIView *oneBgView = [[UIView alloc] initWithFrame:CGRectMake(0, ImageHeight - 40, Width_Screen, 40)];
    oneBgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    [bgScrollView addSubview:oneBgView];
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
    
    // 属性记录
    _imageScrollView = imageScrollView;
    _bgScrollView = bgScrollView;
    _wrapperScrollView = wrapperScrollView;
    _apartmentNameLabel = apartmentNameLabel;
    _pictureCountLabel = pictureCountLabel;
}



@end
