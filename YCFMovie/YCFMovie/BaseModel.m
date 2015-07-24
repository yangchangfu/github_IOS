//
//  BaseModel.m
//  MapListDemo
//
//  基础模型
//
//  Created by yangchangfu on 15-5-2.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)initWithContent:(NSDictionary *)json
{
    self= [super init];
    if (self) {
        
        [self setModelData:json];
    }
    
    return self;
}

/*
 - (id)mapAttributes
 {
    // key : property  value: JSON key
    NSDictionary *mapDic = @{
    @"box" : @"box",
    @"rank" : @"rank",
    @"subject" : @"subject"
    };

    return mapDic;
 } // 建立映射表

 */

// 建立映射表
- (id)mapAttributes
{
    return nil;
}

// 生成setter方法
- (SEL)setterMethod:(NSString *)key
{
    // 获得key的首字母，并大写
    NSString *first = [[key substringToIndex:1] capitalizedString];
    
    // 获得key后面部分，保持原型
    NSString *end   = [key substringFromIndex:1];
    
    // : 一定要有，否则setter方法生成会出错
    NSString *setterName = [NSString stringWithFormat:@"set%@%@:",first,end];
    
    //NSLog(@"setter方法:%@",setterName);
    
    // 指定字符串，生成一个方法
    SEL sel = NSSelectorFromString(setterName);
    
    return sel;
}

- (void)setModelData:(NSDictionary *)json
{
    NSDictionary *mapDic = [self mapAttributes];
    
    for (id key in mapDic) {
        
        // 生成setter方法
        SEL sel = [self setterMethod:key];
        
        // 有效性判断
        if ([self respondsToSelector:sel]) {
            
            // 获得JSON key
            id value = [mapDic objectForKey:key];
            
            // 获得JSON value
            id jsonValue = [json objectForKey:value];
            
            // 执行赋值操作 － [self setTitle:@"title"];
            [self performSelector:sel withObject:jsonValue];
        }
    }
}

@end
