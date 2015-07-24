//
//  USAViewController.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "USAViewController.h"
#import "YCFNetworkService.h"
#import "DetailViewController.h"
#import "MovieModel.h"
#import "USACell.h"
#import "PosterView.h"

#define kListItemTag   101
#define kPosterItemTag 102

@interface USAViewController ()

//加载列表视图
- (void)loadListView;
//加载海报视图
- (void)loadPosterView;
//加载自定义navigationItem视图的rightItem
- (void)loadCustomRightItem;
//反转过渡动画效果
- (void)animationBaseView:(UIView *)baseView withFlag:(BOOL)flag;

///////////////////////////
//请求网络数据
- (void)requestNetData;

//刷新UI
- (void)reflashUI;

@end

@implementation USAViewController

#pragma mark - ViewController LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"北美电影榜";
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    //加载海报视图
    [self loadPosterView];
    //加载列表视图
    [self loadListView];
    //加载自定义navigationItem视图的rightItem
    [self loadCustomRightItem];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //请求"网络"数据 - 多线程／异步
    //[self requestNetData];
    
    //模拟请求网络数据
    [self performSelector:@selector(requestNetData) withObject:nil afterDelay:1];
}

#pragma mark - Private Methods

//加载列表视图
- (void)loadListView
{
    _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49) style:UITableViewStylePlain];
    _listView.backgroundColor = [UIColor blackColor];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.indicatorStyle = UIScrollViewIndicatorStyleWhite;//白色滚动条
    [_listView flashScrollIndicators];//提示用户
    
    [self.view addSubview:_listView];
}

//加载海报视图
- (void)loadPosterView
{
    _posterView = [[PosterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49)];
    _posterView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_posterView];
}

//加载自定义navigationItem视图的rightItem
- (void)loadCustomRightItem
{
    //添加基视图
    UIView *itemBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 49, 25)];
    itemBaseView.userInteractionEnabled = YES;//用户交互
    itemBaseView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"exchange_bg_home"]];
    
    //给基视图添加手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBrowseAction:)];
    singleTap.numberOfTapsRequired = 1;
    [itemBaseView addGestureRecognizer: singleTap];
    [singleTap release];
    
    //添加子视图
    //添加列表视图
    UIImageView *listItem = [[UIImageView alloc] initWithFrame:CGRectMake(itemBaseView.width/2.0-23.0/2.0, itemBaseView.height/2.0-14.0/2.0, 23, 14)];
    listItem.image = [UIImage imageNamed:@"list_home"];
    listItem.tag = kListItemTag;
    listItem.hidden = YES;
    //listItem.contentMode = UIViewContentModeScaleAspectFit;
    [itemBaseView addSubview:listItem];
    [listItem release];
    
    //添加海报视图
    UIImageView *posterItem = [[UIImageView alloc] initWithFrame:CGRectMake(itemBaseView.width/2.0-22.0/2.0, itemBaseView.height/2.0-15.0/2.0, 22, 15)];
    posterItem.hidden = NO;//隐藏海报视图
    posterItem.tag = kPosterItemTag;
    posterItem.image = [UIImage imageNamed:@"poster_home"];
    //posterItem.contentMode = UIViewContentModeScaleAspectFit;
    [itemBaseView addSubview:posterItem];
    [posterItem release];
    
    //设置navigationItem的右Item
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:itemBaseView];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    [itemBaseView release];
}

//反转过渡动画效果
- (void)animationBaseView:(UIView *)baseView withFlag:(BOOL)flag
{
    //实现切换动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    /*
    if (flag) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:baseView cache:YES];
    } else {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:baseView cache:YES];
    }
     */
    
    [UIView setAnimationTransition:flag ? UIViewAnimationTransitionFlipFromLeft: UIViewAnimationTransitionFlipFromRight forView:baseView cache:YES];
    
    [baseView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [UIView commitAnimations];
}

////////////////////////////////////////

//刷新UI
- (void)reflashUI
{
    //MovieModel *movieModal = [_subjectsArray objectAtIndex:0];
    //NSLog(@"content 1 :%@",[movieModal.subject objectForKey:@"title"]);
    //NSLog(@"content 2 :%@",[movieModal.subject objectForKey:@"images"]);
    //NSLog(@"content 3 :%@",[movieModal.subject objectForKey:@"id"]);
    
    [_listView reloadData];
    [_posterView reloadPosterData:_subjectsArray];
}

//请求网络数据
- (void)requestNetData
{
    NSArray *result = [YCFNetworkService northUSAData];
    
    _subjectsArray = [[NSMutableArray alloc] initWithCapacity:result.count];
    
    for (id json in result) {
        MovieModel *movieModel = [[MovieModel alloc] initWithContent:json];
    /*
//        movieModel.box     = [data objectForKey:@"box"];
//        movieModel.rank    = [data objectForKey:@"rank"];
//        movieModel.subject = [data objectForKey:@"subject"];
//        //NSLog(@"box:%@",movieModel.box);
//        NSLog(@"box:%@",movieModel.box);
//        NSLog(@"box:%@",movieModel.rank);
//        NSLog(@"box:%@",movieModel.subject);
//   
  */
        [_subjectsArray addObject:movieModel];
        [movieModel release];
    }
    
    //刷新UI
    [self reflashUI];
}

#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_subjectsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    USACell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[USACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    
    //cell.backgroundColor = [UIColor blackColor];
    //cell.textLabel.textColor = [UIColor whiteColor];
    //cell.textLabel.text = @"test";
    
    cell.movieModel = _subjectsArray[indexPath.row];//获得数据
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"测试：%s",__FUNCTION__);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [[[DetailViewController alloc] init]autorelease];
    detailVC.isShowBackItem = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - Target Action

//改变浏览方式
- (void)changeBrowseAction:(UITapGestureRecognizer *)gesture
{
    //获得itemBaseView基视图
    UIView *baseItemView = [self.navigationItem.rightBarButtonItem customView];
    UIView *listItem = [baseItemView viewWithTag:kListItemTag];
    UIView *posterItem = [baseItemView viewWithTag:kPosterItemTag];
    
    [self animationBaseView:self.view withFlag:posterItem.hidden];
    [self animationBaseView:baseItemView withFlag:posterItem.hidden];
    
    if (posterItem.hidden) {
        posterItem.hidden = NO;
        listItem.hidden = YES;
    } else {
        posterItem.hidden = YES;
        listItem.hidden = NO;
    }
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (self.view.window == nil) {
        self.view = nil;
        //将所有的强引用释放
        //[_data release],_data = nil;
        
        [_listView release],_listView = nil;
        [_posterView release],_posterView = nil;
        [_subjectsArray release], _subjectsArray = nil;
    }

}

- (void)dealloc
{
    [_listView release],_listView = nil;
    [_posterView release],_posterView = nil;
    [_subjectsArray release], _subjectsArray = nil;
    
    [super dealloc];
}


@end
