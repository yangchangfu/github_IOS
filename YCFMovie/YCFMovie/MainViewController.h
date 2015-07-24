//
//  MainViewController.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemView.h" 
#import "MoreView.h"

@interface MainViewController : UITabBarController<ItemViewDelegate,MoreViewDelegate>
{
@private
    UIImageView *_tabBarBG;
    UIImageView *_selectView;
    MoreView    *_moreView;
}

- (void)showOrHiddenCustomedTabBarView:(BOOL)isShow;

@end
