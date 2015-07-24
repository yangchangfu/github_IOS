//
//  NewsViewController.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "NewsViewController.h"
#import "AlbumViewController.h"
#import "YCFNetworkService.h"
#import "NewsModel.h"
#import "ItemView.h"

#define kHeaderViewTitleHeight  30
#define kTableViewRowHeight 60

@interface NewsViewController ()

// 请求网络数据
- (void)requestNetWorkData;
// 刷新UI界面数据
- (void)reflashUI;
// 初始化头部视图
- (void)initHeaderView;

@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"新闻";
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    //self.view.backgroundColor = [UIColor redColor];
    
    // 初始化表视图
    _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49) style:UITableViewStylePlain];
    _newsTableView.hidden = YES;// 等待网络
    _newsTableView.dataSource = self;
    _newsTableView.delegate = self;
    _newsTableView.rowHeight = kTableViewRowHeight;
    
    [self.view addSubview:_newsTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 请求网络数据
    //[self requestNetWorkData];
    // 模拟网络加载数据
    [self performSelector:@selector(requestNetWorkData) withObject:nil afterDelay:1];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 返回选择的行
    NSIndexPath *indexPath = [_newsTableView indexPathForSelectedRow];
    NSLog(@"--->%@",indexPath);
    // 取消选中行
    [_newsTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Private Methods

// 请求网络数据
- (void)requestNetWorkData
{
     NSArray *data = [YCFNetworkService newsData];
    _newsArray = [[NSMutableArray alloc] initWithCapacity:data.count];

    for (NSDictionary *json in data) {
        NewsModel *newsModal  = [[NewsModel alloc] initWithContent:json];
        /*
//        newsModal.newsID      = [dic objectForKey:@"id"];
//        newsModal.newsType    = [dic objectForKey:@"type"];
//        newsModal.newsImgURL  = [dic objectForKey:@"image"];
//        newsModal.newsTitle   = [dic objectForKey:@"title"];
//        newsModal.newsSummary = [dic objectForKey:@"summary"];
        */
        [_newsArray addObject:newsModal];
        [newsModal release];
    }
    
    [self reflashUI];
}

// 刷新UI界面数据
- (void)reflashUI
{
    // 更新表视图的头部视图
    [self initHeaderView];
    
    // 更新表视图
    [_newsTableView reloadData];
    
    // 显示表视图
    _newsTableView.hidden = NO;
}

// 初始化头部视图
- (void)initHeaderView
{
    // 初始化头部视图
    ItemView *headerView = [[ItemView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 166)];
    //headerView.backgroundColor = [UIColor redColor];
    
    // 设置子视图的属性
    headerView.item.frame = CGRectMake(0, 0, headerView.width, headerView.height);
    headerView.title.frame = CGRectMake(0, headerView.height-kHeaderViewTitleHeight,headerView.width, kHeaderViewTitleHeight);
    headerView.title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    headerView.title.font = [UIFont boldSystemFontOfSize:16];
    
    // 添加到表视图的头部
    _newsTableView.tableHeaderView = headerView;
    [headerView release];
    
    // 给子视图赋值
    NewsModel *newsModel = _newsArray[0];
    [headerView.item setImageWithURL:[NSURL URLWithString:newsModel.newsImgURL]];
    headerView.title.text = newsModel.newsTitle;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *newsModel = _newsArray[indexPath.row+1];
    //NSLog(@"%@",newsModel.newsType);
    
    if ([newsModel.newsType intValue] == kTextCellType) {
        
    } else if ([newsModel.newsType intValue] == kImageCellType) {

        AlbumViewController *albumVC = [[[AlbumViewController alloc] init] autorelease];
        
        [self.navigationController pushViewController:albumVC animated:YES];
        
    } else if ([newsModel.newsType intValue] == kMovieCellType) {
        
        
    }

}

#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = _newsArray.count-1;
    
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        
        // 图片视图
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, kTableViewRowHeight-10)];
        imgView.tag = 2015;
        [cell.contentView addSubview:imgView];
        [imgView release];
        
        // 标题视图
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+5, imgView.top, 240, 25)];
        titleLabel.tag = 2016;
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [cell.contentView addSubview:titleLabel];
        [titleLabel release];
        
        // 副标题视图
        UILabel *detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+10, titleLabel.bottom, 220, 25)];
        detailTitle.tag = 2017;
        detailTitle.font = [UIFont systemFontOfSize:14];
        detailTitle.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:detailTitle];
        [detailTitle release];
        
        // logo视图
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(imgView.right+5, titleLabel.bottom+5, 16, 14)];
        logoView.tag = 2018;
        logoView.hidden = YES;
        [cell.contentView addSubview:logoView];
        [logoView release];
        
        // 辅助类型
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NewsModel *newsModel = _newsArray[indexPath.row+1];//获得模型数据
    
    // 赋值
    UIImageView *imgView  = (UIImageView *)[cell.contentView viewWithTag:2015];
    UILabel *title        = (UILabel *)[cell.contentView viewWithTag:2016];
    UILabel *detail       = (UILabel *)[cell.contentView viewWithTag:2017];
    UIImageView *logoView = (UIImageView *)[cell.contentView viewWithTag:2018];
    
    [imgView setImageWithURL:[NSURL URLWithString:newsModel.newsImgURL]];
    title.text = newsModel.newsTitle;
    detail.text = newsModel.newsSummary;
    
    int type = [newsModel.newsType intValue];
    if (type == kTextCellType)
    {
        logoView.hidden = YES;
        detail.left = imgView.right+10;
    }
    else if (type == kImageCellType)
    {
        logoView.hidden = NO;
        logoView.image = [UIImage imageNamed:@"sctpxw"];
        detail.left = logoView.right+5;
    }
    else if (type == kMovieCellType)
    {
        logoView.hidden = NO;
        logoView.image = [UIImage imageNamed:@"scspxw"];
        detail.left = logoView.right+5;
    }

    return cell;
}

#pragma mark - Memory

- (void)dealloc
{
    [_newsTableView release],_newsTableView = nil;
    [_newsArray release],_newsArray = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (self.view.window == nil) {
        self.view = nil;
        //将所有的强引用释放
        //[_data release],_data = nil;
        
    }

}

@end
