//
//  AlbumViewController.h
//  YCFMovie
//
//  Created by yangchangfu on 15-5-2.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AlbumView.h"

@interface AlbumViewController : BaseViewController<AlbumViewDelegate,UIScrollViewDelegate>
{
    @private
    UIImageView   *_navigationBarView;
    UIScrollView  *_contentScrollView;
    UILabel       *_titleView;
    
    NSMutableArray *_detailArray;
}
@end
