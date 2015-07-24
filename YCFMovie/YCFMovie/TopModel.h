//
//  TopModel.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "BaseModel.h"

@interface TopModel : BaseModel

@property (nonatomic, retain)NSNumber *topID;
@property (nonatomic, retain)NSNumber *topRating;
@property (nonatomic, retain)NSString *topTitle;
@property (nonatomic, retain)NSDictionary *topImgsDic;

@end
