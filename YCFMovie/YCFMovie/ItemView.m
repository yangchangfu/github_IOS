//
//  ItemView.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "ItemView.h"


@interface ItemView ()

//初始化视图
- (void)initSubViews;

//添加手势
- (void)addGestures;

@end

@implementation ItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubViews];
        [self addGestures];
    }
    return self;
}

#pragma mark - Private Methods

- (void)initSubViews
{
    //大图标
    _item = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2.0-11, 5, 22, 22)];
    _item.userInteractionEnabled = YES;//用户交互使能
    _item.contentMode = UIViewContentModeScaleAspectFit;//自适应
    [self addSubview:_item];
    
    //小标题
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, _item.bottom,self.width,10)];
    _title.userInteractionEnabled = YES;//用户交互使能
    _title.textColor = [UIColor whiteColor];
    _title.font = [UIFont boldSystemFontOfSize:10];
    _title.backgroundColor = [UIColor clearColor];
    _title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_title];
}

- (void)addGestures
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectItemView:)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
    [singleTap release];
}

- (void)dealloc
{
    [_item release],_item = nil;
    [_title release],_title = nil;
    [super dealloc];
}

#pragma mark - Target Action

- (void)didSelectItemView:(UITapGestureRecognizer *)gesture
{
    //NSLog(@"self tag:%d",self.tag);
    
    if ([self.delegate respondsToSelector:@selector(itemView:didSelectItemAtIndex:)]) {
        
        [self.delegate itemView:self didSelectItemAtIndex:self.tag];
    }
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
