//
//  NSAttributedString+YHAddition.m
//  Tools
//
//  Created by 杨应海 on 2015/12/4.
//  Copyright © 2015年 YYH. All rights reserved.
//

#import "NSAttributedString+YHAddition.h"

@implementation NSAttributedString (YHAddition)


+ (instancetype)yh_imageTextWithImage:(UIImage *)image imageWH:(CGFloat)imageWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing {
   
    NSDictionary *titleDict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName: titleColor};
    NSDictionary *spacingDict = @{NSFontAttributeName: [UIFont systemFontOfSize:spacing]};

    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, imageWH, imageWH);
    NSAttributedString *imageText = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSAttributedString *lineText = [[NSAttributedString alloc] initWithString:@"\n\n" attributes:spacingDict];
    
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:title attributes:titleDict];
    
    NSMutableAttributedString *attM = [[NSMutableAttributedString alloc] initWithAttributedString:imageText];
    [attM appendAttributedString:lineText];
    [attM appendAttributedString:text];
    
    return attM.copy;
}

@end
