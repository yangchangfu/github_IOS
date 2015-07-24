//
//  CinemaModel.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "BaseModel.h"

@interface CinemaModel : BaseModel

@property (nonatomic, retain)NSNumber *cinemaID;
@property (nonatomic, copy)  NSString *cinemaTitle;
@property (nonatomic, copy)  NSString *cinemaImage;
@property (nonatomic, copy)  NSString *cinemaType;
@property (nonatomic, copy)  NSString *cinemaReleaseDate;
@property (nonatomic, copy)  NSString *cinemaDirector;

@end
