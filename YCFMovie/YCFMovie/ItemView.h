//
//  ItemView.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemView;

//自定义ItemView类的协议
@protocol ItemViewDelegate <NSObject>

//@required

//自定义ItemView类的协议方法
@optional

// 用户选择Item
- (void)itemView:(ItemView *)itemView didSelectItemAtIndex:(NSInteger)index;

@end

@interface ItemView : UIView
{
@private
    UIImageView          *_item;
    UILabel              *_title;
    id <ItemViewDelegate> _delegate;
}

@property (nonatomic,readonly) UIImageView          *item;
@property (nonatomic,readonly) UILabel              *title;
@property (nonatomic,assign) id <ItemViewDelegate> delegate;

@end



