//
//  HotHouseDetailViewController.m
//  HaiDeHui
//
//  Created by junde on 2017/6/1.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HotHouseDetailViewController.h"

@interface HotHouseDetailViewController ()

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
    
    
}



@end
