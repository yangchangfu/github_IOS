//
//  NewsModel.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

/*
 "id" : 1491518,
 "type" : 1,
 "image" : "http://img31.mtime.cn/mg/2012/06/28/090602.27750699.jpg",
 "title" : "《搜索》王珞丹特辑",
 "summary" : "搜索,陈凯歌,王珞丹"
 */

// 建立映射表
- (id)mapAttributes
{
    NSDictionary *mapDic = @{@"newsID": @"id",
                             @"newsType": @"type",
                             @"newsTitle": @"title",
                             @"newsSummary": @"summary",
                             @"newsImgURL": @"image"
                             };
    return mapDic;
}

#pragma mark - Memory

- (void)dealloc
{
    self.newsID = nil;
    self.newsType = nil;
    self.newsTitle = nil;
    self.newsSummary = nil;
    self.newsImgURL = nil;
    
    [super dealloc];
}

@end
