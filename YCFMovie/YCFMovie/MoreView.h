//
//  MoreView.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoreView;

@protocol MoreViewDelegate <NSObject>

@optional

// 用户点击背景视图
- (void)moreView:(MoreView *)moreView didTouchBackgroundWithTag:(NSInteger)tag;
// 用户点击表视图
- (void)moreView:(MoreView *)moreView didSelectRowAtIndex:(NSInteger)index;

@end

@interface MoreView : UIView<UITableViewDataSource,UITableViewDelegate>
{
@private
    UITableView *_tableView;
    UIImageView *_popView;
    id <MoreViewDelegate> _delegate;
}

@property(nonatomic,assign)id <MoreViewDelegate> delegate;


@end
