//
//  CommentCell.m
//  YCFMovie
//
//  Created by yangchangfu on 15-5-4.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "CommentCell.h"
#import "MovieCommentModel.h"


@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initSubviews
{
    // 用户头像
    _headerView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_headerView];
    
    // 背景图片
    _cellBG = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage *img = [UIImage imageNamed:@"movieDetail_comments_frame"];
    UIImage *newImg = [img stretchableImageWithLeftCapWidth:img.size.width/2.0 topCapHeight:img.size.height/2.0];
    _cellBG.image = newImg;
    [self.contentView addSubview:_cellBG];
    
    // 用户昵称
    _nickName = [[UILabel alloc] initWithFrame:CGRectZero];
    _nickName.backgroundColor = [UIColor clearColor];
    _nickName.font = [UIFont systemFontOfSize:14];
    _nickName.textColor = [UIColor grayColor];
    [_cellBG addSubview:_nickName];
    
    // 用户评分
    _rating = [[UILabel alloc] initWithFrame:CGRectZero];
    _rating.backgroundColor = [UIColor clearColor];
    _rating.font = [UIFont systemFontOfSize:14];
    _rating.textColor = [UIColor grayColor];
    [_cellBG addSubview:_rating];
    
    // 用户评论
    _content = [[UILabel alloc] initWithFrame:CGRectZero];
    _content.backgroundColor = [UIColor clearColor];
    _content.font = [UIFont boldSystemFontOfSize:16];
    _content.numberOfLines = 0;
    [_cellBG addSubview:_content];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 用户头像
    _headerView.frame = CGRectMake(10, 10, 40, 40);
    [_headerView setImageWithURL:[NSURL URLWithString:_commentModel.userImage]];
    
    // 背景图片
    
    // 用户昵称
    _nickName.frame = CGRectMake(25, 5, 110, 20);
    _nickName.text = _commentModel.nickname;
    
    // 用户评分
    _rating.frame = CGRectMake(_nickName.right+30, 5, 80, 20);
    _rating.text = _commentModel.rating;
    
    // 用户评论
    // 计算内容的大小
    CGSize size = [_commentModel.content sizeWithFont:_content.font constrainedToSize:CGSizeMake(220, 1000)];
    // 设置显示内容的frame
    _content.frame = CGRectMake(25, _nickName.bottom+3, 220, size.height);
    _content.text = _commentModel.content;
    
    // 背景图片
    // 设置显示背景的frame
    _cellBG.frame = CGRectMake(_headerView.right, 5, 260, _content.height+_nickName.height+20);
}

- (void)dealloc
{
    // 注意监测内存的管理，释放有效释放
    self.commentModel = nil;
    [_cellBG release],_cellBG = nil;
    [_headerView release],_headerView = nil;
    [_nickName release],_nickName = nil;
    [_rating release],_rating = nil;
    [_commentModel release],_content = nil;
    
    [super dealloc];
}

@end
