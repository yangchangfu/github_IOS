//
//  CommentCell.h
//  YCFMovie
//
//  Created by yangchangfu on 15-5-4.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieCommentModel;

@interface CommentCell : UITableViewCell
{
@private
    UIImageView *_cellBG;
    UIImageView *_headerView;
    UILabel     *_nickName;
    UILabel     *_rating;
    UILabel     *_content;
}

@property(nonatomic,retain)MovieCommentModel *commentModel;

@end
