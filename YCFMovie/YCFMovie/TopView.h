//
//  TopView.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemView.h"

@class RatingView,TopModel;

@interface TopView : UIView<ItemViewDelegate>
{
@private
    ItemView   *_itemView;
    RatingView *_ratingView;
    
}

@property(nonatomic,retain)TopModel *topModel;

@end
