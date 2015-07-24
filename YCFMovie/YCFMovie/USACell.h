//
//  USACell.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-25.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieModel,RatingView;

@interface USACell : UITableViewCell
{
@private
    UIImageView *_imgView;
    UILabel     *_titleLabel;
    UILabel     *_yearLabel;
    RatingView  *_ratingView;
    MovieModel  *_movieModel;
}

@property (nonatomic,retain)MovieModel  *movieModel;

@end
