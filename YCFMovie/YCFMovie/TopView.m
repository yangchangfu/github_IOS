//
//  TopView.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "TopView.h"
//#import "ItemView.h"
#import "RatingView.h"
#import "TopModel.h"

@implementation TopView

#pragma mark - init Methods
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _itemView = [[ItemView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-15)];
        
        _itemView.delegate = self;//设置代理
        
        // 更改_itemView的frame
        // 图片视图的frame
        _itemView.item.frame = CGRectMake(0, 0, _itemView.width, _itemView.height-20);
        _itemView.item.contentMode = UIViewContentModeScaleToFill;//更改图片显示模式属性
        
        // 标题视图的frame
        _itemView.title.frame = CGRectMake(0, _itemView.height-20, _itemView.width, 20);
        _itemView.title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        _itemView.title.font = [UIFont boldSystemFontOfSize:11];
        [self addSubview:_itemView];
        
        // 更改_ratingView的frame
        _ratingView = [[RatingView alloc] initWithFrame:CGRectMake(0,_itemView.bottom,0,0)];
        
        [self addSubview:_ratingView];
        
    }
    return self;
}

#pragma mark - Setter Methods
- (void)setTopModel:(TopModel *)topModel
{
    if (_topModel != topModel) {
        [_topModel release];
        _topModel = [topModel retain];
        
        // 给_itemView赋值
        [_itemView.item setImageWithURL:[NSURL URLWithString:[_topModel.topImgsDic objectForKey:@"medium"]]];
        _itemView.title.text = _topModel.topTitle;
        
        // 赋值ID号
        _itemView.tag = [topModel.topID intValue];
        
        // 给_ratingView赋值
        _ratingView.style = kSmallStyle;
        _ratingView.rating = [topModel.topRating floatValue];
        _ratingView.ratingTextColor = [UIColor purpleColor];
    }
}

#pragma mark - ItemView Delegate
- (void)didItemView:(ItemView *)itemview atIndex:(NSInteger)index
{
    NSLog(@"ID tag:%d",index);
    
    // 响应者链
    /*
    id next = [itemview nextResponder];
    while (next != nil) {
        next = [next nextResponder];
        NSLog(@"responder:%@",next);
        
        if ([next isKindOfClass:[UIViewController class]]) {
            NSLog(@"----:%@",next);
            UIViewController *topVC = (UIViewController *)next;
            
            [topVC.navigationController pushViewController:nil animated:YES];
            
            return;
        }
    }
     */
}

#pragma mark - Memory
- (void)dealloc
{
    [_itemView release] ,_itemView = nil;
    [_ratingView release] ,_ratingView = nil;
    self.topModel = nil;
    
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
