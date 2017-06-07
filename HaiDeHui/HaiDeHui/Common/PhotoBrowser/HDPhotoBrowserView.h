//
//  HDPhotoBrowserView.h
//  HaiDeHui
//
//  Created by junde on 2017/6/6.
//  Copyright © 2017年 junde. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDPhotoBrowserView;

@protocol HDPhotoBrowserViewDelegate <NSObject>

/** 告诉上一级控制器当前的下标,以便做适当处理 */
- (void)photoBrowserView:(HDPhotoBrowserView *)photoBrowser currentIndex:(NSInteger)index;

@end

@interface HDPhotoBrowserView : UIView

/** 代理属性 */
@property (nonatomic, weak) id <HDPhotoBrowserViewDelegate> delegate;

/**
 初始化方法 currentIndex 和 imageUrls 必传参数
    placeholderImage 和 sourceView 可为空

 @param currentIndex 当前的图片对应的数组下标
 @param imageUrls 图片浏览器要呈现的图片的URL数组
 @param placeholderImage 占位图片
 @param sourceView 原来的小图片的源视图/父视图
 @return 返回初始化的图片浏览器
 */
- (instancetype)initWithCurrentIndex:(NSInteger)currentIndex
                       imageURLArray:(NSArray <NSString *>*)imageUrls
                    placeholderImage:(UIImage *)placeholderImage
                          sourceView:(UIView *)sourceView;

/**
 展示图片浏览器
 */
- (void)show;

@end
