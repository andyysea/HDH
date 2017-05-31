//
//  HDNavigationController.m
//  HaiDeHui
//
//  Created by junde on 2017/5/31.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HDNavigationController.h"

@interface HDNavigationController ()

@end

@implementation HDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationBar.hidden = YES;
}

#pragma mark - push压栈统一隐藏tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

#pragma mark - 重写状态栏属性getter方法,让压栈控制器能在自己文件里改状态栏颜色
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end
