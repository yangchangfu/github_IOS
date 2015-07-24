//
//  NewsViewController.h
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef enum kCellType {
    kTextCellType  = 0,
    kImageCellType = 1,
    kMovieCellType = 2
    
} kCellType;

@interface NewsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
@private
    UITableView    *_newsTableView;
    NSMutableArray *_newsArray;
}
@end
