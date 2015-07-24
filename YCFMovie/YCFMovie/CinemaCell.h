//
//  CinemaCell.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CinemaModel;

@interface CinemaCell : UITableViewCell
{
@private
    UIImageView *_imgView;
    UILabel     *_titleLabel;
    UILabel     *_typeLabel;
    UILabel     *_directorLabel;
    
    UIImageView *_releaseDateView;
    UILabel     *_monthLabel;
    UILabel     *_dayLabel;
}

@property(nonatomic,retain)CinemaModel *cinemaModel;

@end
