//
//  AlbumViewController.m
//  YCFMovie
//
//  Created by yangchangfu on 15-5-2.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "AlbumViewController.h"
#import "MainViewController.h"
#import "YCFNetworkService.h"
#import "ImagesModel.h"


#define kScrollViewGas 30 //相册的间隔大小

@interface AlbumViewController ()

// 自定义NavigationBar视图
- (void)customNavigationBarView;

// 内容视图
- (void)loadBaseScrollView;

// 详细内容视图
- (void)loadTitleLabel;

// 请求网络数据
- (void)requestData;

// 刷新界面
- (void)refreshUI;

// 加载图片数据
- (void)loadImagesWithIndex:(NSInteger)index;

@end

@implementation AlbumViewController

#pragma mark - Viewcontroller LifeCycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count == 2) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        // 隐藏自定义TabBar
        MainViewController *mainVC = (MainViewController *)self.tabBarController;
        [mainVC showOrHiddenCustomedTabBarView:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        // 显示自定义TabBar
        MainViewController *mainVC = (MainViewController *)self.tabBarController;
        [mainVC showOrHiddenCustomedTabBarView:YES];
    }

}

- (void)loadView
{
    [super loadView];
    
    //self.view.backgroundColor = [UIColor greenColor];
    
    // 内容视图
    [self loadBaseScrollView];
    
    // 自定义NavigationBar视图
    [self customNavigationBarView];
    
    // 详细内容视图
    [self loadTitleLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 请求"网络"数据
    [self requestData];
}

#pragma mark - Private Methods
// 自定义NavigationBar视图
- (void)customNavigationBarView
{
    _navigationBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, kDeviceWidth, 44)];
    _navigationBarView.userInteractionEnabled = YES;//用户交互开启
    _navigationBarView.image = [UIImage imageNamed:@"nav_bg_all"];
    [self.view addSubview:_navigationBarView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBarView addSubview:backBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 44)];
    titleLabel.text = @"电影图片";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    titleLabel.backgroundColor = [UIColor clearColor];
    [_navigationBarView addSubview:titleLabel];
    [titleLabel release];
}

// 内容视图
- (void)loadBaseScrollView
{
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, kDeviceWidth+kScrollViewGas, kDeviceHeight-20)];
    _contentScrollView.backgroundColor = [UIColor whiteColor];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.tag = INT32_MAX;
    
    [self.view addSubview:_contentScrollView];
}

// 详细内容视图
- (void)loadTitleLabel
{
    _titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceHeight-49, kDeviceWidth, 49)];
    _titleView.backgroundColor = [UIColor blackColor];
    _titleView.textColor = [UIColor whiteColor];
    _titleView.font = [UIFont boldSystemFontOfSize:18];
    _titleView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleView];
}

///////////////////////////////////////

// 请求网络数据
- (void)requestData
{
    NSArray *data = [YCFNetworkService newsDetailData];
            
    _detailArray = [[NSMutableArray alloc] initWithCapacity:data.count];
    
    for (id json in data) {
        ImagesModel *imageModel = [[ImagesModel alloc] initWithContent:json];
        [_detailArray addObject:imageModel];
        [imageModel release];
    }

    // 刷新界面
    [self refreshUI];
}

// 刷新界面
- (void)refreshUI
{
    // 设置滑动视图的内容大小
    _contentScrollView.contentSize = CGSizeMake((kDeviceWidth+kScrollViewGas)*_detailArray.count, _contentScrollView.height);
    
    // 设置初始标题
    ImagesModel *imageModel = _detailArray[0];
    _titleView.text = imageModel.detailTitle;
    
    // 添加图片的视图和滑动视图
    int x=0;
    for (int index=0; index<_detailArray.count; index++) {
        
        // 取出数据
        ImagesModel *imageModel = _detailArray[index];
        
        // 创建视图
        AlbumView *albumView = [[AlbumView alloc] initWithFrame:CGRectMake(0+x, 0, kDeviceWidth, kDeviceHeight-20)];
        
        albumView.delegate = self;// 设置代理
        
        albumView.tag = index;
        
        // 先加载两种图片
        if (index < 2) {
            albumView.imgURL = imageModel.detailImageUrl;
            [albumView loadScrollViewImages];
        }
       
        [_contentScrollView addSubview:albumView];
        [albumView release];
        
        x += (kDeviceWidth+kScrollViewGas);
    }
}

// 加载图片数据
- (void)loadImagesWithIndex:(NSInteger)index
{
    ImagesModel *imagesModel = _detailArray[index];
    AlbumView *albumView = (AlbumView *)[_contentScrollView viewWithTag:index];
    albumView.imgURL = imagesModel.detailImageUrl;
    
    [albumView loadScrollViewImages];
}

#pragma mark - ScrollView Delegate

static int last_index=0;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"----scrollViewDidEndDecelerating----");
    
    int index = scrollView.contentOffset.x / (kDeviceWidth+kScrollViewGas);
    
    //NSLog(@"当前页码：%d",index);
    
    // 有效性判断
    if (index >= _detailArray.count || index < 0) {
        return;
    }
    
    ImagesModel *imagesModel = _detailArray[index];
    _titleView.text = imagesModel.detailTitle;
    
    // 获得滑动子视图
    AlbumView *albumView = (AlbumView *)[_contentScrollView viewWithTag:last_index];
    if (albumView.scrollview.zoomScale != 1 && last_index != index) {
        
        //[albumView.scrollview setZoomScale:1 animated:YES];
        albumView.scrollview.zoomScale = 1;
    }
    
    // 记录上次的选择
    last_index = index;
    
    int cnt = _detailArray.count;
    
    if (index == 0) {
        for (int i=0; i<2; i++) {
            // 加载前面2张图片
            //NSLog(@"----index:%d",i);
            [self loadImagesWithIndex:i];
        }
        
    } else if (index == cnt-1){
        
        for (int i=index; i>index-2; i--) {
            // 加载最后2张图片
            //NSLog(@"----index:%d",i);
            [self loadImagesWithIndex:i];
        }
        
    } else {
        
        for (int i=index+1; i>index-2; i--) {
            // 同时加载前后2张图片
            //NSLog(@"----index:%d",i);
            [self loadImagesWithIndex:i];
        }
    }
}

#pragma mark - AlbumView Delegate
- (void)albumView:(AlbumView *)albumView HiddenOrShowSidedViews:(id)object
{
    // 隐藏两边的导航视图和底部标题视图
    // 更改背景颜色
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    if (_navigationBarView.alpha==1 && _titleView.alpha==1 ) {
        
        _navigationBarView.alpha = 0;
        _titleView.alpha = 0;
        _navigationBarView.bottom = 0;
        _titleView.top = kDeviceHeight;
        // 更改背景颜色
        _contentScrollView.backgroundColor = [UIColor blackColor];
        
    } else {
        
        _navigationBarView.alpha = 1;
        _titleView.alpha = 1;
        _navigationBarView.bottom = 60;
        _titleView.top = kDeviceHeight-40;
        // 更改背景颜色
        _contentScrollView.backgroundColor = [UIColor whiteColor];
    }
    [UIView commitAnimations];
}

#pragma mark - Target Action
- (void)backAction:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_navigationBarView release],_navigationBarView = nil;
    [_contentScrollView release],_contentScrollView = nil;
    [_titleView release],_titleView = nil;
    [_detailArray release],_detailArray = nil;
    
    [super dealloc];
}

@end
