//
//  HDPhotoBrowserLoadingView.h
//  HaiDeHui
//
//  Created by junde on 2017/6/6.
//  Copyright © 2017年 junde. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, HDPhotoBrowserLoadingType){
    HDPhotoBrowserLoadingLoopDiagram,  // 环形
    HDPhotoBrowserLoadingPieDiagram    // 饼形
};

@interface HDPhotoBrowserLoadingView : UIView

/** 加载进度类型 --> 默认环形 */
@property (nonatomic, assign) HDPhotoBrowserLoadingType loadingType;

/** 加载的进度 */
@property (nonatomic, assign) CGFloat progress;

@end
