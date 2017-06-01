//
//  HDBaseViewController.h
//  HaiDeHui
//
//  Created by junde on 2017/5/31.
//  Copyright © 2017年 junde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDBaseViewController : UIViewController

/** 提供给子类控制器,用于修改导航栏颜色等 */
@property (nonatomic, strong) UINavigationBar *navigationBar;

/** 提供给子类控制器修改导航栏 '标题' 或者添加 rightBarButtonItems  */
@property (nonatomic, strong) UINavigationItem *navItem;

@end
