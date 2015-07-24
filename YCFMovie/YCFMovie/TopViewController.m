//
//  TopViewController.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "TopViewController.h"
#import "YCFNetworkService.h"
#import "TopModel.h"
#import "TopCell.h"

/*
 * 存在Buger问题：
    1. 评级星星，显示不对（cell复用）
    2. 
 */


@interface TopViewController ()

- (void)requestNetworkData;
- (void)reflashUI;

@end

@implementation TopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Top 250";
    }
    return self;
}

#pragma mark - View LifeCycle 
- (void)loadView
{
    [super loadView];
    
    // 初始化表视图
    _topTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49) style:UITableViewStylePlain];
    
    _topTableView.hidden = YES;// 等待网络
    _topTableView.dataSource = self;
    _topTableView.delegate = self;
    //_topTableView.rowHeight = 150;
    _topTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_topTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 请求加载网络数据
    // [self requestNetworkData];
    [self performSelector:@selector(requestNetworkData) withObject:nil afterDelay:1];
    
}

#pragma mark - Private Methods
// 请求网络数据
- (void)requestNetworkData
{
    //NSLog(@"topMovie:%@",[YCFNetworkService topMovieData]);
    
    NSArray *data = [YCFNetworkService topMovieData];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:data.count];
    // 遍历所有数据
    for (NSDictionary *json in data) {
        TopModel *topModel = [[TopModel alloc] initWithContent:json];
        /*
//        topModel.topID = [content objectForKey:@"id"];
//        topModel.topTitle = [content objectForKey:@"title"];
//        topModel.topRating = [content objectForKey:@"rating"];
//        topModel.topImgsDic = [content objectForKey:@"images"];
        */
        [array addObject:topModel];
        [topModel release];
    }
    
    // 创建二维数组
    NSMutableArray *temp = nil;
    _topMovieArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<data.count; i++) {
        TopModel *topModel = array[i];
        
        if (i%3 == 0) {
            temp = [[[NSMutableArray alloc] initWithCapacity:3] autorelease];
            [_topMovieArray addObject:temp];
            // [temp release];
        }
        [temp addObject:topModel];
    }
    
    //_topMovieArray =[@[@[@"1",@"2",@"3"],@[@"1",@"2",@"3"],@[@"1",@"2",@"3"],@[@"1",@"2",@"3"],@[@"1",@"2",@"3"],@[@"1",@"2"]] mutableCopy];
    
    
    [array release];
    
    // 测试数据
    // NSLog(@"test:%@",_topMovieArray);
    
    // 刷新UI界面
    [self reflashUI];
}

// 刷新UI界面
- (void)reflashUI
{
    [_topTableView reloadData];
    
    _topTableView.hidden = NO;// 等待网络
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _topMovieArray.count-1) {
        return 170;
    } else {
        return 150;
    }
}

#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_topMovieArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    TopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[TopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.imgsArray = _topMovieArray[indexPath.row];// 赋值
   
    return cell;
}

#pragma mark - Memory

- (void)dealloc
{
    [_topTableView release],_topTableView = nil;
    [_topMovieArray release],_topMovieArray = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (self.view.window == nil) {
        self.view = nil;
        //将所有的强引用释放
        
        [_topTableView release],_topTableView = nil;
        [_topMovieArray release],_topMovieArray = nil;
    }
}

@end
