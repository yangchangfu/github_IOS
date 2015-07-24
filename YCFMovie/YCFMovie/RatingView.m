//
//  RatingView.m
//  RatingViewDemo
//
//  Created by yangchangfu on 15-4-25.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "RatingView.h"

#define kNormalHeight   33 //星星尺寸1
#define kNormalWidth    35

#define kSmallHeight    14 //星星尺寸2
#define kSmallWidth     15

#define kFullMark       10 //评级最大分数

#define kNormalFontSize 25 //评级字体大小
#define kSmallFontSize  12

#define kStarNumber     5  //评级星星的数量

@implementation RatingView

//视图初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化
        [self initGrayStarsView];
        [self initYellowStarsView];
        [self initRatingLabel];
    }
    return self;
}

#pragma mark - init Subviews

//初始化灰色星星视图，布局放在layout中
- (void)initGrayStarsView
{
    _grayStarsArray = [[NSMutableArray alloc] initWithCapacity:kStarNumber];
    
    for (int index=0; index<kStarNumber; index++) {
        UIImageView *grayStarView = [[UIImageView alloc] initWithFrame:CGRectZero];
        grayStarView.image = [UIImage imageNamed:@"gray"];
        [self addSubview:grayStarView];
        [grayStarView release];
        [_grayStarsArray addObject:grayStarView];
    }
}

//初始化灰色星星视图，布局放在layout中
- (void)initYellowStarsView
{
    //基视图
    _baseView = [[UIView alloc] initWithFrame:CGRectZero];
    _baseView.backgroundColor = [UIColor clearColor];//透明背景
    _baseView.clipsToBounds = YES;//设置边缘裁剪使能
    [self addSubview:_baseView];
    
    _yellowStarsArray = [[NSMutableArray alloc] initWithCapacity:kStarNumber];
    
    for (int index=0; index<kStarNumber; index++) {
        UIImageView *yellowStarView = [[UIImageView alloc] initWithFrame:CGRectZero];
        yellowStarView.image = [UIImage imageNamed:@"yellow"];
        [_baseView addSubview:yellowStarView];
        [yellowStarView release];
        [_yellowStarsArray addObject:yellowStarView];
    }
}

//初始化评级视图，布局放在layout中
- (void)initRatingLabel
{
    _ratingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _ratingLabel.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_ratingLabel];
}

#pragma mark - OverWrite Setting Method

//复写评级级数属性
- (void)setRating:(CGFloat)rating 
{
    _rating = rating;
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",_rating];
}

//复写评级数字的字体颜色属性，以便可以修改字体颜色
-(void)setRatingTextColor:(UIColor *)ratingTextColor
{
    _ratingLabel.textColor = ratingTextColor;
}

#pragma mark - Layout Subviews

//视图所有布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //取出黄色和灰色的星星，改变其frame
    int width = 0;
    for (int index=0; index<kStarNumber; index++) {
        UIView *yellowStar = _yellowStarsArray[index];
        UIView *grayStar = _grayStarsArray[index];
        
        if (self.style == kSmallStyle) {
            yellowStar.frame = CGRectMake(0+width, 0, kSmallWidth, kSmallHeight);
            grayStar.frame = CGRectMake(0+width, 0, kSmallWidth, kSmallHeight);
            width += kSmallWidth;
        } else {
            yellowStar.frame = CGRectMake(0+width, 0, kNormalWidth, kNormalHeight);
            grayStar.frame = CGRectMake(0+width, 0, kNormalWidth, kNormalHeight);
            width += kNormalWidth;
        }
    }
    //初始化baseView的宽度，根据计算，算出baseView的宽度
    float baseViewWidth = self.rating/kFullMark*width;
    CGFloat height = 0;
    
    if (self.style == kSmallStyle) {
        _baseView.frame = CGRectMake(0, 0, baseViewWidth, kSmallHeight);
        _ratingLabel.font = [UIFont boldSystemFontOfSize:kSmallFontSize];
        height = kSmallHeight;
    } else {
        _baseView.frame = CGRectMake(0, 0, baseViewWidth, kNormalHeight);
        _ratingLabel.font = [UIFont boldSystemFontOfSize:kNormalFontSize];
        height = kNormalHeight;
    }
    //设置评级label的frame
    _ratingLabel.frame = CGRectMake(width, 0, 0, 0);
    [_ratingLabel sizeToFit];
    
    //设置视图的frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width+_ratingLabel.frame.size.width, height);
}

#pragma mark - Memory

- (void)dealloc
{
    [_baseView release],_baseView = nil;
    [_ratingLabel release],_ratingLabel = nil;
    [_grayStarsArray release],_grayStarsArray = nil;
    [_yellowStarsArray release],_yellowStarsArray = nil;
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
