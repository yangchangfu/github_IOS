//
//  LaunchViewController.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-30.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

// 制定协议
@protocol  LaunchViewControllerDelegate <NSObject>

@optional
- (void)loadLogoViewAnimationEnd;

@end


@interface LaunchViewController : BaseViewController
{
@private
    int _imagesCount;
    int _maxRow;
    
    NSMutableArray *_logoArray;
    id <LaunchViewControllerDelegate> _delegate;
}

@property(nonatomic,assign) id <LaunchViewControllerDelegate> delegate;

@end
