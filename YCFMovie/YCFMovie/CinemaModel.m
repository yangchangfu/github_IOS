//
//  CinemaModel.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "CinemaModel.h"

@implementation CinemaModel

/*
 "id" : 153149,
 "title" : "搜索",
 "image" : "http://img31.mtime.cn/mt/2012/06/28/225616.52472061.jpg",
 "releaseDate" : "7月6日上映",
 "type" : "剧情/悬疑",
 "director" : "陈凯歌",
 "wantedCount" : 1319
*/

// 建立映射表
- (id)mapAttributes
{
    NSDictionary *mapDic = @{@"cinemaID": @"id",
                             @"cinemaTitle": @"title",
                             @"cinemaImage": @"image",
                             @"cinemaType": @"type",
                             @"cinemaReleaseDate": @"releaseDate",
                             @"cinemaDirector": @"director"
                             };
    return mapDic;
}

#pragma mark - Memory

- (void)dealloc
{
    self.cinemaID = nil;
    self.cinemaTitle = nil;
    self.cinemaImage = nil;
    self.cinemaType = nil;
    self.cinemaReleaseDate = nil;
    self.cinemaDirector = nil;
    
    [super dealloc];
}

@end
