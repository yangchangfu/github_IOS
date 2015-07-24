//
//  CommentViewController.h
//  YCFMovie
//
//  Created by yangchangfu on 15-5-3.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "BaseViewController.h"

@class MovieInfoModel,MovieCommentModel;

@interface CommentViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
@private
    UITableView       *_commentTableView;
    UIView            *_baseHeaderView;
    
    MovieInfoModel    *_infoModel;
    NSMutableArray    *_commentModelArray;
}

@end
