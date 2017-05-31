//
//  RequestManager.h
//  HaiDeHui
//
//  Created by junde on 2017/5/31.
//  Copyright © 2017年 junde. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 用于网络方法请求 --> 本类用于MKNetwork 如果使用AFN从新创建文件 */
@interface RequestManager : NSObject

#pragma mark - 单例对象,用于调用网络请求方法
+ (instancetype)sharedInstance;


@end
