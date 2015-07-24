//
//  YCFNetworkService.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "YCFNetworkService.h"
#import "JSONKit.h"

@implementation YCFNetworkService

//解析数据
+ (id)parserData:(NSString *)name
{
    //获得包路径
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    //根据文件名，拼接完整路径
    NSString *path = [resourcePath stringByAppendingPathComponent:name];
    //转换数据，读出数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //－－－－－－－－解析JSON数据－－－－－－－－－－－－－
    
    //版本判断
    id result = nil;
    NSString *version = [UIDevice currentDevice].systemVersion;
    if ([version floatValue] >= 5.0) {
        //JSONSerialization解析 apple自带
        result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    } else {
        //5.0以前，JSONKit解析方法
        result = [data objectFromJSONData];
    }
    
    return result;
}

// 获取测试数据
+ (id)testData
{
    return [self parserData:@"dataJson.geojson"];
}

// 获取北美票房数据
+ (id)northUSAData
{
    return [[self parserData:@"NorthUSA.json"] objectForKey:@"subjects"];
}

// 获取新闻数据
+ (id)newsData
{
    return [self parserData:@"news_list.json"];
}

// 获取新闻详情数据
+ (id)newsDetailData
{
    return [self parserData:@"news_detail_images.json"];
}

// 获取topMovie数据
+ (id)topMovieData
{
    return [[self parserData:@"movie_list.json"] objectForKey:@"entries"];
}

// 获取Cinema数据
+ (id)cinemaData
{
    return [self parserData:@"readyMovie.json"];
}

// 获取电影详情数据
+ (id)movieInfoData
{
    return [self parserData:@"movie_detail.json"]; 
}

// 获取电影评论数据
+ (id)movieCommentData
{
    return [[self parserData:@"movie_comment.json"] objectForKey:@"list"];
}

@end
