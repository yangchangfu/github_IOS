//
//  USACell.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-25.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "USACell.h"
#import "MovieModel.h"

#import "RatingView.h"

@implementation USACell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //初始化子视图
        [self initSubviews];
        self.backgroundColor = [UIColor blackColor];
        self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - init Subviews

- (void)initSubviews
{
    //图片视图
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imgView.backgroundColor = [UIColor clearColor];
    //_imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imgView];
    
    //标题视图
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor orangeColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_titleLabel];

    //年份标签视图
    _yearLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _yearLabel.backgroundColor = [UIColor clearColor];
    _yearLabel.textColor = [UIColor whiteColor];
    _yearLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_yearLabel];
    
    //评级视图
    _ratingView = [[RatingView alloc] initWithFrame:CGRectZero];
    _ratingView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_ratingView];
}

#pragma mark - Layout Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSDictionary *contentDic = self.movieModel.subject;
    
    //图片视图
    _imgView.frame    = CGRectMake(10, 10, 45, 60);
    NSString *imgString = [[contentDic objectForKey:@"images"] objectForKey:@"medium"];
    //同步网络请求获取资源
    /*
    NSURL *url = [NSURL URLWithString:imgString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _imgView.image = [UIImage imageWithData:data];
    */
    //异步网络请求获取资源
    [_imgView setImageWithURL:[NSURL URLWithString:imgString]];
    
    //标题视图
    _titleLabel.frame = CGRectMake(_imgView.right+10, 10, 180, 30);
    _titleLabel.text = [contentDic objectForKey:@"title"];
    
    //年份视图
    _yearLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom, _titleLabel.width/2.0, 30);
    _yearLabel.text = [NSString stringWithFormat:@"年份: %@",[contentDic objectForKey:@"year"]];
    
    //评级视图
    _ratingView.frame = CGRectMake(_yearLabel.right, _titleLabel.bottom+6, _yearLabel.width, 30);
    _ratingView.style = kSmallStyle;
    _ratingView.rating = [[[contentDic objectForKey:@"rating"] objectForKey:@"average"] floatValue];
    _ratingView.ratingTextColor = [UIColor redColor];
}

#pragma mark - Memory

- (void)dealloc
{
    [_imgView release],_imgView = nil;
    [_titleLabel release],_titleLabel = nil;
    [_yearLabel release],_yearLabel = nil;
    [_ratingView release],_ratingView = nil;
    
    [super dealloc];
}

@end
