//
//  MovieInfoModel.h
//  YCFMovie
//
//  Created by yangchangfu on 15-5-3.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "BaseModel.h"

@interface MovieInfoModel : BaseModel

@property (nonatomic,copy)  NSString *imageURL;
@property (nonatomic,copy)  NSString *titleCn;
@property (nonatomic,copy)  NSString *content;
@property (nonatomic,retain) NSArray *types;
@property (nonatomic,retain) NSArray *directors;
@property (nonatomic,retain) NSArray *actors;
@property (nonatomic,retain) NSDictionary *release;
@property (nonatomic,retain) NSArray *images;
@property (nonatomic,retain) NSArray *videos;

@end
