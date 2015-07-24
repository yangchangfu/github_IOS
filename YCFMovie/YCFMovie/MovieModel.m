//
//  MovieModel.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-25.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel

// 建立映射表
- (id)mapAttributes
{
    // key : property  value: JSON key
    NSDictionary *mapDic = @{
                             @"box" : @"box",
                             @"rank" : @"rank",
                             @"subject" : @"subject"
                            };
    
    return mapDic;
} 

- (void)dealloc
{
    self.box     = nil;
    self.rank    = nil;
    self.subject = nil;
    
    [super dealloc];
}

@end
