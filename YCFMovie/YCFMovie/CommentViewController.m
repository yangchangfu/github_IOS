//
//  CommentViewController.m
//  YCFMovie
//
//  Created by yangchangfu on 15-5-3.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "CommentViewController.h"
#import "MainViewController.h"
#import "YCFNetworkService.h"
#import "MovieInfoModel.h"
#import "MovieCommentModel.h"
#import "CommentCell.h"

@interface CommentViewController ()

- (void)loadCommentTableView;
- (void)loadHeaderView;

- (void)requestMovieInfoData;
- (void)requestMovieCommentData;
- (void)refreshUIWithMovieInfo;
- (void)refreshUIWithMovieComment;

@end

@implementation CommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"电影详情";
    }
    return self;
}

#pragma mark - ViewController LifeCycle
- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    
    [self loadCommentTableView];
    
    [self loadHeaderView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count == 2) {
        
        // 隐藏自定义TabBar
        MainViewController *mainVC = (MainViewController *)self.tabBarController;
        [mainVC showOrHiddenCustomedTabBarView:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count == 1) {
        
        // 显示自定义TabBar
        MainViewController *mainVC = (MainViewController *)self.tabBarController;
        [mainVC showOrHiddenCustomedTabBarView:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self requestMovieInfoData];
        
    [self requestMovieCommentData];
}

#pragma mark - Private Methods
- (void)loadCommentTableView
{
    _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44) style:UITableViewStylePlain];
    _commentTableView.dataSource = self;
    _commentTableView.delegate = self;
    _commentTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _commentTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_commentTableView];
}

- (void)loadHeaderView
{
    // 表视图的头部视图 － 基视图
    _baseHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 300)];
    _baseHeaderView.backgroundColor = [UIColor clearColor];
    
    // 电影的海报视图
    UIImageView *posterView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 110, 150)];
    posterView.backgroundColor = [UIColor clearColor];
    posterView.tag = 101;
    [_baseHeaderView addSubview:posterView];
    [posterView release];
    
    // 电影的标题
    UILabel *movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(posterView.right+10, posterView.top, 170, 20)];
    movieTitle.backgroundColor = [UIColor clearColor];
    movieTitle.textColor = [UIColor orangeColor];
    movieTitle.textAlignment = NSTextAlignmentLeft;
    movieTitle.font = [UIFont boldSystemFontOfSize:16];
    movieTitle.tag = 102;
    [_baseHeaderView addSubview:movieTitle];
    [movieTitle release];
    
    // 电影的导演
    UILabel *movieDirector = [[UILabel alloc] initWithFrame:CGRectMake(posterView.right+10, movieTitle.bottom, 170, 20)];
    movieDirector.backgroundColor = [UIColor clearColor];
    movieDirector.textColor = [UIColor whiteColor];
    movieDirector.textAlignment = NSTextAlignmentLeft;
    movieDirector.font = [UIFont boldSystemFontOfSize:15];
    movieDirector.tag = 103;
    [_baseHeaderView addSubview:movieDirector];
    [movieDirector release];
    
    // 电影的演员
    UILabel *movieActors = [[UILabel alloc] initWithFrame:CGRectMake(posterView.right+10, movieDirector.bottom, 170, 45)];
    movieActors.backgroundColor = [UIColor clearColor];
    movieActors.textColor = [UIColor whiteColor];
    movieActors.textAlignment = NSTextAlignmentLeft;
    movieActors.numberOfLines = 0;
    [movieActors setAdjustsFontSizeToFitWidth:YES];
    movieActors.font = [UIFont boldSystemFontOfSize:15];
    movieActors.tag = 104;
    [_baseHeaderView addSubview:movieActors];
    [movieActors release];
    
    // 电影的类型
    UILabel *movieType = [[UILabel alloc] initWithFrame:CGRectMake(posterView.right+10, movieActors.bottom, 170, 45)];
    movieType.backgroundColor = [UIColor clearColor];
    movieType.textColor = [UIColor cyanColor];
    movieType.textAlignment = NSTextAlignmentLeft;
    movieType.numberOfLines = 0;
    movieType.font = [UIFont boldSystemFontOfSize:15];
    movieType.tag = 105;
    [_baseHeaderView addSubview:movieType];
    [movieType release];
    
    // 电影的上映地和日期
    UILabel *movieDate = [[UILabel alloc] initWithFrame:CGRectMake(posterView.right+10, movieType.bottom, 170, 20)];
    movieDate.backgroundColor = [UIColor clearColor];
    movieDate.textColor = [UIColor yellowColor];
    movieDate.textAlignment = NSTextAlignmentLeft;
    movieDate.font = [UIFont boldSystemFontOfSize:15];
    movieDate.tag = 106;
    [_baseHeaderView addSubview:movieDate];
    [movieDate release];
    
    // “想看”按钮
    UIButton *wantingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wantingBtn.frame = CGRectMake(20, posterView.bottom+10, 140, 40);
    [wantingBtn setTitle:@"想看" forState:UIControlStateNormal];
    [wantingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    wantingBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    //[wantingBtn setBackgroundColor:[UIColor greenColor]];
    [wantingBtn setBackgroundImage:[UIImage imageNamed:@"xk"] forState:UIControlStateNormal];
    [wantingBtn setBackgroundImage:[UIImage imageNamed:@"xk_on"] forState:UIControlStateHighlighted];
    [_baseHeaderView addSubview:wantingBtn];
    
    // “评分”按钮
    UIButton *ratingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ratingBtn.frame = CGRectMake(wantingBtn.right, posterView.bottom+10, 140, 40);
    [ratingBtn setTitle:@"评分" forState:UIControlStateNormal];
    [ratingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ratingBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    //[ratingBtn setBackgroundColor:[UIColor purpleColor]];
    [ratingBtn setBackgroundImage:[UIImage imageNamed:@"ypf"] forState:UIControlStateNormal];
    [ratingBtn setBackgroundImage:[UIImage imageNamed:@"ypf_on"] forState:UIControlStateHighlighted];
    [_baseHeaderView addSubview:ratingBtn];
    
    // 子表视图
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(20, ratingBtn.bottom+10, 280, 280) style:UITableViewStylePlain];
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.tag = 107;
    tableview.scrollEnabled = NO;
    tableview.backgroundView = nil;
    tableview.layer.cornerRadius = 5;// 圆角设置
    
    NSLog(@"tableview :%@",tableview);
    
    [_baseHeaderView addSubview:tableview];
    [tableview release];
    
    // 重新设置 _baseHeaderView 的高度
    _baseHeaderView.height = tableview.bottom + 10;
    
    // 把基视图付给表视图的头部视图
    _commentTableView.tableHeaderView = _baseHeaderView;
}

////////////////////////////////

- (void)requestMovieInfoData
{
    NSDictionary *dic = [YCFNetworkService movieInfoData];
    //NSLog(@"MovieInfo:%@",dic);
    
    _infoModel = [[MovieInfoModel alloc] initWithContent:dic];
    /*
//    NSLog(@"MovieInfo:%@",_infoModel.imageURL);
//    NSLog(@"MovieInfo:%@",_infoModel.titleCn);
//    NSLog(@"MovieInfo:%@",_infoModel.content);
//    NSLog(@"MovieInfo:%@",_infoModel.types);
//    NSLog(@"MovieInfo:%@",_infoModel.directors);
//    NSLog(@"MovieInfo:%@",_infoModel.actors);
//    NSLog(@"MovieInfo:%@",_infoModel.release);
//    NSLog(@"MovieInfo:%@",_infoModel.images);
//    NSLog(@"MovieInfo:%@",_infoModel.videos);
    */
    
    // 得到电影详情，刷新UI
    [self refreshUIWithMovieInfo];
}

- (void)requestMovieCommentData
{
    NSArray *data = [YCFNetworkService movieCommentData];
    //NSLog(@"MovieComment:%@",data);
    
    _commentModelArray = [[NSMutableArray alloc] initWithCapacity:data.count];
    
    for (id dic in data) {
        MovieCommentModel *commetModel = [[MovieCommentModel alloc] initWithContent:dic];
        [_commentModelArray addObject:commetModel];
        [commetModel release];
    }
    
    // 得到电影评论数据，刷新UI
    [self refreshUIWithMovieComment];
}

- (void)refreshUIWithMovieInfo
{
    // 电影的海报视图
    UIImageView *posterView = (UIImageView *)[_baseHeaderView viewWithTag:101];
    [posterView setImageWithURL: [NSURL URLWithString:_infoModel.imageURL]];
    
    // 电影的标题
    UILabel *movieTitle = (UILabel *)[_baseHeaderView viewWithTag:102];
    movieTitle.text = _infoModel.titleCn;
    
    // 电影的导演
    UILabel *movieDirector = (UILabel *)[_baseHeaderView viewWithTag:103];
    movieDirector.text = [NSString stringWithFormat:@"导演：%@",[_infoModel.directors componentsJoinedByString:@" "]];
    
    // 电影的演员
    UILabel *movieActors = (UILabel *)[_baseHeaderView viewWithTag:104];
    movieActors.text = [NSString stringWithFormat:@"演员：%@",[_infoModel.actors componentsJoinedByString:@"  "]];
    
    // 电影的类型
    UILabel *movieType  = (UILabel *)[_baseHeaderView viewWithTag:105];
    movieType.text = [NSString stringWithFormat:@"类型：%@",[_infoModel.types componentsJoinedByString:@"  "]];
    
    // 电影的上映地和日期
    UILabel *movieDate  = (UILabel *)[_baseHeaderView viewWithTag:106];
    movieDate.text = [NSString stringWithFormat:@"上映：%@",[[_infoModel.release allValues] componentsJoinedByString:@" "]];
    
    // 刷新表视图（子视图）
    UITableView *tableView = (UITableView *)[_baseHeaderView viewWithTag:107];
    [tableView reloadData];
}

- (void)refreshUIWithMovieComment
{
    [_commentTableView reloadData];
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_commentTableView == tableView) {
        
        // 根据内容大小，设置cell的高度
        MovieCommentModel *commentModel = _commentModelArray[indexPath.row];
        CGSize size = [commentModel.content sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(220, 1000)];//计算内容的大小
        
        return (size.height+20+25);
        
    } else {
        if (indexPath.row == 0 || indexPath.row == 3) {
            
            return 85;
        } else {
            
            return 55;
        }
    }
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_commentTableView == tableView) {
        
        return _commentModelArray.count;
    } else {
        
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 电影评论列表
    if (_commentTableView == tableView) {
        static NSString *cellIdentifier = @"cell";
        
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        
        cell.commentModel =_commentModelArray[indexPath.row];// 赋值
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
        
    } else { // 电影详情的子列表
        
        UITableViewCell *mycell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        
        mycell.selectionStyle = UITableViewCellSelectionStyleNone;//不可选择
        
        if (indexPath.row == 0) {
            int x=0;
            for (int index=0; index<_infoModel.images.count; index++) {
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10+x, 5, 61, 75)];
                NSString *imgURL = _infoModel.images[index];
                [imgView setImageWithURL:[NSURL URLWithString:imgURL]];
                [mycell.contentView addSubview:imgView];
                [imgView release];
                x += 61+5;
            }
            
        } else if (indexPath.row == 1) {
            
            mycell.textLabel.text = _infoModel.content;
            
        } else if (indexPath.row == 2) {
            
            NSString *actors = [_infoModel.actors componentsJoinedByString:@","];
            mycell.textLabel.text = [NSString stringWithFormat:@"职员表：%@",actors];
            
        } else {
            
            int _x=0;
            for (int i=0; i<_infoModel.videos.count; i++) {
                UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(10+_x, 5, 83, 75)];
                
                NSDictionary *dic = _infoModel.videos[i];
                NSString *imgURL = [dic objectForKey:@"image"];
                [view setImageWithURL:[NSURL URLWithString:imgURL]];
                
                [mycell.contentView addSubview:view];
                [view release];
                _x += 83+5;
            }
        }

        return mycell;
    }
    
}

#pragma mark - Target Action
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (self.view.window == nil) {
        self.view = nil;
        
        // 同时，释放全部的强引用
        [_commentTableView release],_commentTableView = nil;
        [_baseHeaderView release],_baseHeaderView = nil;
        [_infoModel release],_infoModel = nil;
        [_commentModelArray release],_commentModelArray = nil;
    }
}

- (void)dealloc
{
    [_commentTableView release],_commentTableView = nil;
    [_baseHeaderView release],_baseHeaderView = nil;
    [_infoModel release],_infoModel = nil;
    [_commentModelArray release],_commentModelArray = nil;
    
    [super dealloc];
}

@end
