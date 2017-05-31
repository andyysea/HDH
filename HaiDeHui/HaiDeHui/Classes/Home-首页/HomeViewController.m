//
//  HomeViewController.m
//  HaiDeHui
//
//  Created by junde on 2017/5/31.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HomeViewController.h"
#import "TestViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navItem.title = @"首页";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:button];
    button.center = self.view.center;
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick:(UIButton *)button {
    
    [self.navigationController pushViewController:[TestViewController new] animated:YES];
}



@end
