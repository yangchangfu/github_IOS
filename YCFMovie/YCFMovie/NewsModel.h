//
//  NewsModel.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "BaseModel.h"

@interface NewsModel : BaseModel

@property (nonatomic, retain)NSNumber *newsID;
@property (nonatomic, retain)NSNumber *newsType;
@property (nonatomic, copy)  NSString *newsTitle;
@property (nonatomic, copy)  NSString *newsSummary;
@property (nonatomic, copy)  NSString *newsImgURL;

@end
