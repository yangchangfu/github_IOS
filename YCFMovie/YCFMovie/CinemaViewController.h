//
//  CinemaViewController.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CinemaViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
@private
    UITableView    *_cinemaTableView;
    NSMutableArray *_cinemaArray;
}

@property(nonatomic,retain)NSMutableArray *cinemaArray;

@end
