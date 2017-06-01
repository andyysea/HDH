//
//  HDBaseViewController.m
//  HaiDeHui
//
//  Created by junde on 2017/5/31.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HDBaseViewController.h"

@interface HDBaseViewController ()

@end

@implementation HDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavgation];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.view bringSubviewToFront:self.navigationBar];
}

#pragma mark - 设置自定义导航栏
- (void)setupNavgation {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationBar *navgationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 64)];
    navgationBar.barTintColor = [UIColor redColor];
    navgationBar.translucent = NO;
    [self.view addSubview:navgationBar];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    navgationBar.items = @[navigationItem];
    
    if (self.navigationController.viewControllers.count > 1) {
        navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popBackClick)];
        navgationBar.tintColor = [UIColor whiteColor];
    }
    [navgationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    _navItem = navigationItem;
    _navigationBar = navgationBar;
}

#pragma mark - leftItem点击返回
- (void)popBackClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
