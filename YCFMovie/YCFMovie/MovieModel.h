//
//  MovieModel.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-25.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "BaseModel.h"

@interface MovieModel : BaseModel

@property (nonatomic,retain) NSNumber     *box;
@property (nonatomic,retain) NSNumber     *rank;
@property (nonatomic,retain) NSDictionary *subject;

@end
