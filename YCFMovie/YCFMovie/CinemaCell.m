//
//  CinemaCell.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "CinemaCell.h"
#import "CinemaModel.h"

#define kGas 10
#define kImageViewHeight 80
#define kImageViewWidth 60

#define kLabelHeight 25
#define kLabelWidth 150


@interface CinemaCell ()

- (void)initSubviews;

@end

@implementation CinemaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化
        [self initSubviews];
        
        // 辅助图标设置
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)initSubviews
{
    // 图片
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imgView];
    
    // 标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_titleLabel];
    
    // 类型
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _typeLabel.textColor = [UIColor lightGrayColor];
    _typeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_typeLabel];

    // 导演 
    _directorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _directorLabel.textColor = [UIColor lightGrayColor];
    _directorLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_directorLabel];

    // 发布日期
    _releaseDateView = [[UIImageView alloc] initWithFrame:CGRectZero];
    //_releaseDateView.backgroundColor = [UIColor redColor];
    _releaseDateView.image = [UIImage imageNamed:@"coming_cinema"];
    [self.contentView addSubview:_releaseDateView];
    
    // 月份
    _monthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _monthLabel.textColor = [UIColor whiteColor];
    _monthLabel.font = [UIFont boldSystemFontOfSize:16];
    _monthLabel.textAlignment = NSTextAlignmentCenter;
    [_releaseDateView addSubview:_monthLabel];
    
    // 天
    _dayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _dayLabel.textColor = [UIColor blackColor];
    _dayLabel.font = [UIFont boldSystemFontOfSize:14];
    _dayLabel.textAlignment = NSTextAlignmentCenter;
    [_releaseDateView addSubview:_dayLabel];
}

// 重新布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 图片
    _imgView.frame = CGRectMake(kGas, kGas, kImageViewWidth, kImageViewHeight);
    [_imgView setImageWithURL:[NSURL URLWithString:self.cinemaModel.cinemaImage]];
    
    // 标题
    _titleLabel.frame = CGRectMake(_imgView.right+kGas, _imgView.top, kLabelWidth, kLabelHeight);
    _titleLabel.text = self.cinemaModel.cinemaTitle;
    
    // 类型
    _typeLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom, _titleLabel.width, _titleLabel.height);
    _typeLabel.text = [NSString stringWithFormat:@"类型:%@",self.cinemaModel.cinemaType];
    
    // 导演
    _directorLabel.frame = CGRectMake(_typeLabel.left, _typeLabel.bottom, _typeLabel.width, _typeLabel.height);
    _directorLabel.text = [NSString stringWithFormat:@"导演:%@",self.cinemaModel.cinemaDirector];
    
    // 上映日期 
    _releaseDateView.frame = CGRectMake(_typeLabel.right, 25, 50, 50);
    
    // 处理日期字符串
    char *date = (char*)[self.cinemaModel.cinemaReleaseDate UTF8String];
    int month,day;
    // 指定一个格式化占位符
    sscanf(date, "%d月%d日",&month,&day);
    
    // 月份
    _monthLabel.frame = CGRectMake(0, 0, 50, 25);
    _monthLabel.text = [NSString stringWithFormat:@"%d月",month];
    // 天
    _dayLabel.frame = CGRectMake(0, _monthLabel.bottom, 50, 25);
    _dayLabel.text = [NSString stringWithFormat:@"%d",day];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - Memory

- (void)dealloc
{
    self.cinemaModel = nil;
    [_imgView release],_imgView = nil;
    [_titleLabel release],_titleLabel = nil;
    [_typeLabel release],_typeLabel = nil;
    [_directorLabel release],_directorLabel = nil;
    [_releaseDateView release],_releaseDateView = nil;
    [_monthLabel release],_monthLabel = nil;
    [_dayLabel release],_dayLabel = nil;
    
    [super dealloc];
}

@end
