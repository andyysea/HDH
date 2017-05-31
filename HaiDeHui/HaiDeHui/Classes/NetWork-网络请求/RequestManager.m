//
//  RequestManager.m
//  HaiDeHui
//
//  Created by junde on 2017/5/31.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

#pragma mark - 单例对象,用于调用网络请求方法
+ (instancetype)sharedInstance {
    static RequestManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}





@end
