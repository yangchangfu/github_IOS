//
//  TopModel.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "TopModel.h"

@implementation TopModel

/*
 "rating": 8,
 "pubdate": "2013-03-21",
 "title": "北京遇上西雅图",
 "images": {
 "large": "http://img3.douban.com/view/photo/photo/public/p1910895969.jpg",
 "small": "http://img3.douban.com/view/photo/photo/public/p1910895969.jpg",
 "medium": "http://h.hiphotos.baidu.com/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=a05d5ba840a7d933aba5ec21cc22ba76/8b82b9014a90f603dc63fdfb3b12b31bb151edbf.jpg"
 },
 "id": "10574468",
 "collection": 59681
 */

// 建立映射表
- (id)mapAttributes
{
    NSDictionary *mapDic = @{@"topID":      @"id",
                             @"topTitle":   @"title",
                             @"topRating":  @"rating",
                             @"topImgsDic": @"images"
                             };
    return mapDic;
}

#pragma mark - Memory
- (void)dealloc
{
    self.topID = nil;
    self.topTitle = nil;
    self.topRating = nil;
    self.topImgsDic = nil;
    
    [super dealloc];
}

@end
