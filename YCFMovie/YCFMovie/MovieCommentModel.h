//
//  MovieCommentModel.h
//  YCFMovie
//
//  Created by yangchangfu on 15-5-3.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "BaseModel.h"


@interface MovieCommentModel : BaseModel

@property(nonatomic,copy)NSString *userImage;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *rating;
@property(nonatomic,copy)NSString *content;

@end
