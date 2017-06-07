//
//  HotHouseDetailViewController.m
//  HaiDeHui
//
//  Created by junde on 2017/6/1.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HotHouseDetailViewController.h"
#import "HDPhotoBrowserView.h"

/** 屏幕上方图片的高度 */
#define ImageHeight  (Width_Screen * 9 / 16)
/** 图片滚动视图上面添加的图片的tag基准 */
#define MyImageViewTag  10010

@interface HotHouseDetailViewController ()<UIScrollViewDelegate, HDPhotoBrowserViewDelegate>

/** 底层添加滚动图片的滚动视图 */
@property (nonatomic, weak) UIScrollView *imageScrollView;
/** 用于添加所有子控件的滚动视图 */
@property (nonatomic, weak) UIScrollView *bgScrollView;
/** 添加最上层的滚动视图,用于控制器底层图片滚动视图的滚动 */
@property (nonatomic, weak) UIScrollView *wrapperScrollView;

/** 公寓名 当前页/总页数 的背景视图 */
@property (nonatomic, weak) UIView *oneBgView;
/** 显示的公寓名称 */
@property (nonatomic, weak) UILabel *apartmentNameLabel;
/** 用于显示当期图片/总的图片数量 */
@property (nonatomic, weak) UILabel *currentPicNumberLabel;

/** 当期显示的第几张图片 */
@property (nonatomic, assign) NSInteger currentPage;


/**
 测试数组
 */
@property (nonatomic, strong) NSArray *imageArray;
/** 
 测试高清图数组
 */
@property (nonatomic, strong) NSArray *highImageArray;


@end

@implementation HotHouseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}



#pragma mark - HDPhotoBrowserViewDelegate
- (void)photoBrowserView:(HDPhotoBrowserView *)photoBrowser currentIndex:(NSInteger)index {
    
    NSLog(@" index --> %zd", index);
    self.currentPage = index;
    self.imageScrollView.contentOffset = CGPointMake(index * Width_Screen, 0);
    self.wrapperScrollView.contentOffset = CGPointMake(index *Width_Screen, 0);
 
    self.currentPicNumberLabel.text = [NSString stringWithFormat:@"%zd / %zd", self.currentPage + 1, self.imageArray.count];
}


#pragma mark - 点按手势,用于弹出图片浏览器
- (void)tapGestureClick:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"--> %zd",_currentPage);
    // 显示当前的页数正常之后,点击弹出图片浏览器 self.currentPage 从0开始
    
    // ****** 先使用低质量的图片数组--> 后续可以改
    UIImage *plceholderImage = [(UIImageView *)self.imageScrollView.subviews[self.currentPage] image];
    if (!plceholderImage) {
        return;
    }
    
    HDPhotoBrowserView *browserView = [[HDPhotoBrowserView alloc] initWithCurrentIndex:self.currentPage imageURLArray:self.highImageArray placeholderImage:nil sourceView:nil];
    browserView.delegate = self;
    [browserView show];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = self.bgScrollView.contentOffset.y + self.bgScrollView.contentInset.top;
    CGFloat offsetX = self.wrapperScrollView.contentOffset.x;
    NSInteger currentPage = floor(offsetX / Width_Screen + 0.5);
    if (offsetY < 0) {
        UIImageView *imageView = nil;
        for (UIView *subView in self.imageScrollView.subviews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                if ((subView.tag - MyImageViewTag) == currentPage) {
                    imageView = (UIImageView *)subView;
                    break;
                }
            }
        }
        CGFloat scaleWidth = (ABS(offsetY) + ImageHeight) * Width_Screen / ImageHeight;
        CGRect rect = CGRectMake(- (scaleWidth - Width_Screen) / 2 + currentPage * Width_Screen, 0, scaleWidth, ABS(offsetY) + ImageHeight);
        imageView.frame = rect;
        
        CGRect ImageSVFrame = self.imageScrollView.frame;
        ImageSVFrame.origin.y = 64;
        self.imageScrollView.frame = ImageSVFrame;
        CGRect oneBgViewFrame = self.oneBgView.frame;
        oneBgViewFrame.origin.y = ImageHeight + 64 - 40 + ABS(offsetY);
        self.oneBgView.frame = oneBgViewFrame;
    } else {
        self.imageScrollView.contentOffset = CGPointMake(offsetX, offsetY);;
        
        self.imageScrollView.frame = CGRectMake(0, - offsetY / 3 + 64, Width_Screen, Height_Screen);
        self.oneBgView.frame = CGRectMake(0, - offsetY / 3 + ImageHeight + 64 - 40, Width_Screen, 40);
    }

    self.currentPicNumberLabel.text = [NSString stringWithFormat:@"%zd / %zd", currentPage + 1, self.imageArray.count];
    
    // 属性记录
    _currentPage = currentPage;
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
    _highImageArray = @[
                        @"http://ww2.sinaimg.cn/bmiddle/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/642beb18gw1ep3629gfm0g206o050b2a.gif",
                        @"http://ww4.sinaimg.cn/bmiddle/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                        @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/677febf5gw1erma104rhyj20k03dz16y.jpg",
                        @"http://ww4.sinaimg.cn/bmiddle/677febf5gw1erma1g5xd0j20k0esa7wj.jpg"
                                             ];
    
    // 请求完毕数据之后,设置图片
    NSInteger index = 0;
    for (NSString *urlStr in _imageArray) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index * Width_Screen, 0, Width_Screen, ImageHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"hehe"]];
        imageView.tag = index + MyImageViewTag;
        index++;
        [self.imageScrollView addSubview:imageView];
    }
    self.imageScrollView.contentSize = CGSizeMake(_imageArray.count * Width_Screen, ImageHeight);
    self.wrapperScrollView.contentSize = CGSizeMake(_imageArray.count * Width_Screen, ImageHeight);
    
    // 设置小区名字和页数
    // 当前页面默认初始化是1
    self.currentPicNumberLabel.text = [NSString stringWithFormat:@"1 / %zd", self.imageArray.count];
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
    
    // 2 > 添加显示小区名 好 图片当前页数和总页数的视图
    UIView *oneBgView = [[UIView alloc] initWithFrame:CGRectMake(0, ImageHeight + 64 - 40, Width_Screen, 40)];
    oneBgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    [self.view addSubview:oneBgView];
    // 公寓名标签
    UILabel *apartmentNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, Width_Screen - 80 , 40)];
    apartmentNameLabel.font = [UIFont systemFontOfSize:20];
    apartmentNameLabel.textColor = [UIColor whiteColor];
    apartmentNameLabel.text = @"测试一下";
    [oneBgView addSubview:apartmentNameLabel];
    // 图片页数标签
    UILabel *currentPicNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width_Screen - 70, 0, 60 , 40)];
    currentPicNumberLabel.font = [UIFont systemFontOfSize:20];
    currentPicNumberLabel.textColor = [UIColor whiteColor];
    currentPicNumberLabel.textAlignment = NSTextAlignmentCenter;
    currentPicNumberLabel.text = @"1 / 5";
    [oneBgView addSubview:currentPicNumberLabel];
    
    // 3> 添加底层的滚动视图,用于添加子控件
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Width_Screen, Height_Screen - 64)];
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.delegate = self;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bgScrollView];
    //************* 测试用 ******888888888888*******************************
    bgScrollView.contentSize = CGSizeMake(Width_Screen, Height_Screen * 1.5);
    
    // a> 添加滚动视图,用于控制底层图片滚动视图的滚动
    UIScrollView *wrapperScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, ImageHeight)];
    wrapperScrollView.backgroundColor = [UIColor clearColor];
    wrapperScrollView.delegate = self;
    wrapperScrollView.pagingEnabled = YES;
    wrapperScrollView.showsVerticalScrollIndicator = NO;
    wrapperScrollView.showsHorizontalScrollIndicator = NO;
    [bgScrollView addSubview:wrapperScrollView];
    
    // 添加一个点按手势,用于控制点击上面图片部分弹出图片浏览器
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClick:)];
    [wrapperScrollView addGestureRecognizer:tapGesture];
    

    
    // 添加侧视视图
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, ImageHeight, Width_Screen, Height_Screen - 100)];
    testView.backgroundColor = [UIColor orangeColor];
    [bgScrollView addSubview:testView];
    
    // 属性记录
    _imageScrollView = imageScrollView;
    _oneBgView = oneBgView;
    _apartmentNameLabel = apartmentNameLabel;
    _currentPicNumberLabel = currentPicNumberLabel;
    _bgScrollView = bgScrollView;
    _wrapperScrollView = wrapperScrollView;
}



@end
