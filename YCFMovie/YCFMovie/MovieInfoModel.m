//
//  MovieInfoModel.m
//  YCFMovie
//
//  Created by yangchangfu on 15-5-3.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "MovieInfoModel.h"

@implementation MovieInfoModel

// 建立映射表
- (id)mapAttributes
{
    NSDictionary *mapDic = @{@"imageURL": @"image",
                             @"titleCn":  @"titleCn",
                             @"content":  @"content",
                             @"types":    @"type",
                             @"directors":@"directors",
                             @"actors":   @"actors",
                             @"release":  @"release",
                             @"images":   @"images",
                             @"videos":   @"videos"
                             };
    return mapDic;
}

- (void)dealloc
{
    self.imageURL  = nil;
    self.titleCn   = nil;
    self.content   = nil;
    self.types     = nil;
    self.directors = nil;
    self.actors    = nil;
    self.release   = nil;
    self.images    = nil;
    self.videos    = nil;
    
    [super dealloc];
}

@end
