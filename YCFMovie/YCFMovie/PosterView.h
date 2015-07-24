//
//  PosterView.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-28.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>


//@class TestMaskView;
@interface PosterView : UIView<UIScrollViewDelegate>
{
@private
    UIImageView  *_headerView;
    UIButton     *_headerButton;
    UIScrollView *_headerScrollView;
    
    UIView       *_contentView; //基视图如是UIImageView，必须开启用户交互，否则无法滑动scrollView
    UIScrollView *_contentScrollView;
    
    UIImageView  *_footerView;
    UILabel      *_footTitleLabel;
    
    UIView       *_maskView; //添加遮罩视图
}

@property (nonatomic,retain)NSArray *posterData;//接收海报视图的数据
@property (nonatomic,retain)UIView  *maskView; //添加遮罩视图

// 更新加载海报视图数据
- (void)reloadPosterData:(NSArray *) data;

@end
