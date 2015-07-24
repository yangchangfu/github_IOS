//
//  USAViewController.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class PosterView;

@interface USAViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
@private
    UITableView    *_listView;
    PosterView     *_posterView;
    NSMutableArray *_subjectsArray;//存放数据的数组
}

@end
