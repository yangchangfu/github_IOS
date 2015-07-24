//
//  MovieCommentModel.m
//  YCFMovie
//
//  Created by yangchangfu on 15-5-3.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "MovieCommentModel.h"

@implementation MovieCommentModel

// 建立映射表
- (id)mapAttributes
{
    NSDictionary *mapDic = @{@"userImage": @"userImage",
                            @"nickname":  @"nickname",
                            @"rating":  @"rating",
                            @"content": @"content"
                         };
    return mapDic;
}

- (void)dealloc
{
    self.content   = nil;
    self.userImage = nil;
    self.nickname  = nil;
    self.rating    = nil;
    
    [super dealloc];
}

@end
