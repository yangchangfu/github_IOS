//
//  YCFNetworkService.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCFNetworkService : NSObject

// 解析数据
+ (id)parserData:(NSString *)name;

// 获取测试数据
+ (id)testData;

// 获取北美票房数据
+ (id)northUSAData;

// 获取新闻数据
+ (id)newsData;

// 获取新闻详情数据
+ (id)newsDetailData;

// 获取topMovie数据
+ (id)topMovieData;

// 获取Cinema数据
+ (id)cinemaData;

// 获取电影详情数据
+ (id)movieInfoData;

// 获取电影评论数据
+ (id)movieCommentData;

@end
