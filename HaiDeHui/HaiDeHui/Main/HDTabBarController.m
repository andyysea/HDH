//
//  HDTabBarController.m
//  HaiDeHui
//
//  Created by junde on 2017/5/31.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HDTabBarController.h"
#import "HDNavigationController.h"
#import "HomeViewController.h"          // 首页
#import "HouseSourceViewController.h"   // 房源
#import "DiscoverViewController.h"      // 发现
#import "MyViewController.h"            // 我的


@interface HDTabBarController ()<UITabBarControllerDelegate>


@end


@implementation HDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [self addChildViewControllers];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
   
    return YES;
}


#pragma mark - 添加子控制器
- (void)addChildViewControllers {
    self.tabBar.tintColor = [UIColor redColor];
    NSMutableArray *arrayM = [NSMutableArray array];
    [arrayM addObject:[self viewControllerWithClassName:@"HomeViewController" title:@"首页" imageName:@""]];
    [arrayM addObject:[self viewControllerWithClassName:@"HouseSourceViewController" title:@"房源" imageName:@""]];
    [arrayM addObject:[self viewControllerWithClassName:@"DiscoverViewController" title:@"发现" imageName:@""]];
    [arrayM addObject:[self viewControllerWithClassName:@"MyViewController" title:@"我的" imageName:@""]];
    self.viewControllers = arrayM.copy;
}

- (UIViewController *)viewControllerWithClassName:(NSString *)clsName title:(NSString *)title imageName:(NSString *)imageName {
    
    Class cls = NSClassFromString(clsName);
    NSAssert(cls != nil, @"传入了类名字符串错误");
    UIViewController *vc = [cls new];
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectImage = [UIImage imageNamed:[imageName stringByAppendingString:@"_sel"]];
    vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.title = title;
    HDNavigationController *nav = [[HDNavigationController alloc] initWithRootViewController:vc];
    
    return  nav;
}

@end
