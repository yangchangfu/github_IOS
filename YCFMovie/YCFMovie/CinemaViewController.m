//
//  CinemaViewController.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "CinemaViewController.h"
#import "CommentViewController.h"
#import "YCFNetworkService.h"
#import "CinemaModel.h"
#import "CinemaCell.h"

@interface CinemaViewController ()

// 请求网络数据
- (void)requestNetworkData;
// 处理网络数据
- (void)handleNetworkData;
// 刷新UI界面数据
- (void)refreshUI;

@end

@implementation CinemaViewController

#pragma mark - init Methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"影院";
    }
    return self;
}

#pragma mark - View LifeCycle

- (void)loadView
{
    [super loadView];

    // 初始化表视图
    _cinemaTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49) style:UITableViewStylePlain];
    _cinemaTableView.hidden = YES;// 等待网络
    _cinemaTableView.dataSource = self;
    _cinemaTableView.delegate = self;
    _cinemaTableView.rowHeight = 100;
    
    [self.view addSubview:_cinemaTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //NSLog(@"cinema data:%@",[YCFNetworkService cinemaData]);
    // 请求网络数据
    // [self requestNetworkData];
    // 模拟请求网络
    [self performSelector:@selector(requestNetworkData) withObject:nil afterDelay:1];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 取消选中行
    [_cinemaTableView deselectRowAtIndexPath:[_cinemaTableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - Private Methods
// 请求网络数据
- (void)requestNetworkData
{
    // 请求网络数据
    [self handleNetworkData];
    
    // 完成网络后，重新刷新UI界面
    [self refreshUI];
}

// 处理网络数据
- (void)handleNetworkData
{
    // 获得网络数据
    NSArray *data = [YCFNetworkService cinemaData];
    // 赋值数据
    //_cinemaArray = [[YCFNetworkService cinemaData] retain];
    
    // 初始化数组
    _cinemaArray = [[NSMutableArray alloc] initWithCapacity:data.count];
    // 处理数据
    for (NSDictionary *json in data) {
        CinemaModel *cinemaModel = [[CinemaModel alloc] initWithContent:json];
        /*
//        cinemaModel.cinemaID = [content objectForKey:@"id"];
//        cinemaModel.cinemaTitle = [content objectForKey:@"title"];
//        cinemaModel.cinemaImage = [content objectForKey:@"image"];
//        cinemaModel.cinemaType = [content objectForKey:@"type"];
//        cinemaModel.cinemaReleaseDate = [content objectForKey:@"releaseDate"];
//        cinemaModel.cinemaDirector = [content objectForKey:@"director"];
         */
        [_cinemaArray addObject:cinemaModel];
        [cinemaModel release];
    }
}

// 刷新UI界面数据
- (void)refreshUI
{
    // 刷新表视图
    [_cinemaTableView reloadData];
    // 显示表视图
    _cinemaTableView.hidden = NO;// 等待网络
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentViewController *commentVC = [[[CommentViewController alloc] init] autorelease];
    commentVC.isShowBackItem = YES;// 使用自定义返回按钮
    
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cinemaArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[CinemaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.cinemaModel = _cinemaArray[indexPath.row];//赋值－模型数据
    
    return cell;
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (self.view.window == nil) {
        self.view = nil;
        
        //将所有的强引用释放
        [_cinemaArray release],_cinemaArray = nil;
        [_cinemaTableView release],_cinemaTableView = nil;
    }

}

- (void)dealloc
{
    [_cinemaArray release],_cinemaArray = nil;
    [_cinemaTableView release],_cinemaTableView = nil;
    
    [super dealloc];
}

@end
