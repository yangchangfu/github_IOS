//
//  ImagesModel.m
//  YCFMovie
//
//  Created by yangchangfu on 15-5-2.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "ImagesModel.h"

@implementation ImagesModel

/*
 "title": "宋佳出席亚太电影节盛典",
 "desc": "宋佳长裙清新",
 "url1": "http://img31.mtime.cn/CMS/Gallery/2012/12/17/100617.24696526.jpg",
 "url2": "http://img31.mtime.cn/CMS/Gallery/2012/12/17/100617.24696526_900.jpg"
 */

// 建立映射表
- (id)mapAttributes
{
    NSDictionary *mapDic = @{@"detailTitle"   : @"title",
                             @"detailDesc"    : @"desc",
                             @"detailImageUrl": @"url1",
                            };
    return mapDic;
}

#pragma mark - Memory
- (void)dealloc
{
    self.detailTitle = nil;
    self.detailDesc = nil;
    self.detailImageUrl = nil;
       
    [super dealloc];
}


@end
