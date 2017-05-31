//
//  NSObject+YHRunTime.m
//  Tools
//
//  Created by 杨应海 on 2015/5/4.
//  Copyright © 2015年 YYH. All rights reserved.
//

#import "NSObject+YHRunTime.h"
#import <objc/runtime.h>

@implementation NSObject (YHRunTime)

void *propertiesKey = "cn.yyh.propertiesList";

+ (NSArray *)yh_propertiesList {
    
    NSArray *result = objc_getAssociatedObject(self, propertiesKey);
    
    if (result != nil) {
        return result;
    }
    
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
        
        objc_property_t pty = list[i];
        const char *cName = property_getName(pty);
        NSString *name = [NSString stringWithUTF8String:cName];
        
        [arrayM addObject:name];
    }
    
    free(list);
    objc_setAssociatedObject(self, propertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, propertiesKey);
}



void *ivarsKey = "cn.yyh.ivarsList";

+ (NSArray *)yh_ivarsList {
    
    NSArray *result = objc_getAssociatedObject(self, ivarsKey);
    
    if (result != nil) {
        return result;
    }
    
    unsigned int count = 0;
    Ivar *list = class_copyIvarList([self class], &count);
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
        
        Ivar ivar = list[i];
        const char *cName = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:cName];
        
        [arrayM addObject:name];
    }
    
    free(list);

    objc_setAssociatedObject(self, ivarsKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, ivarsKey);

}




+ (NSArray *)yh_objectsWithArray:(NSArray *)array {
    
    if (array.count == 0) {
        return nil;
    }
    
    NSAssert([array[0] isKindOfClass:[NSDictionary class]], @"必须传入字典数组");
    
    NSArray *list = [self yh_propertiesList];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        id obj = [self new];
        for (NSString *key in dict) {
            
            if (![list containsObject:key]) {
                continue;
            }
            [obj setValue:dict[key] forKey:key];
        }
        
        [arrayM addObject:obj];
    }
    return arrayM.copy;
}

@end
