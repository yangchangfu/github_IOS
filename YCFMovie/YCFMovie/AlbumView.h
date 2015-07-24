//
//  AlbumView.h
//  YCFMovie
//
//  Created by yangchangfu on 15-5-2.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlbumView;
@protocol AlbumViewDelegate <NSObject>

@optional
- (void)albumView:(AlbumView *)albumView HiddenOrShowSidedViews:(id)object;

@end

@interface AlbumView : UIView<UIScrollViewDelegate>
{
@private
    UIScrollView *_scrollview;
    UIImageView *_imageView;
    id <AlbumViewDelegate> _delegate;
}

@property(nonatomic,assign)id <AlbumViewDelegate> delegate;
@property(nonatomic,copy)NSString *imgURL;
@property(nonatomic,readonly)UIScrollView *scrollview;

- (void)loadScrollViewImages;

@end
