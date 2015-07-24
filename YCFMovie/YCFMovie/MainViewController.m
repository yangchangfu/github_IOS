//
//  MainViewController.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "MainViewController.h"
#import "USAViewController.h"
#import "NewsViewController.h"
#import "TopViewController.h"
#import "CinemaViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"


@interface MainViewController ()

// 加载所有的Items到TabBar上面
- (void)loadViewControllers;
// 自定义TabBar界面
- (void)customTabBarView;
// 点击TabBar的item项，切换显示
- (void)changeViewController:(NSInteger)index;
// 移除更多页面的视图
- (void)removeMoreView;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"电影;
        
        //隐藏系统的TabBar视图
        self.tabBar.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //加载所有的Items到TabBar上面
    [self loadViewControllers];
    
    //自定义TabBar界面
    [self customTabBarView];
}


#pragma mark - Private Methods

- (void)loadViewControllers
{
    /*
     USAViewController *usaVC = [[[USAViewController alloc] init] autorelease];
     //    UITabBarItem *usaItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:5 tag:5] autorelease];
     //    usaVC.tabBarItem = usaItem;
     BaseNavigationController *usaNav = [[[BaseNavigationController alloc] initWithRootViewController:usaVC] autorelease];
     */
    
    //北美
    USAViewController *usaVC = [[[USAViewController alloc] init] autorelease];
    BaseNavigationController *usaNav = [[[BaseNavigationController alloc] initWithRootViewController:usaVC] autorelease];
    
    //新闻
    NewsViewController *newsVC = [[[NewsViewController alloc] init] autorelease];
    BaseNavigationController *newsNav = [[[BaseNavigationController alloc] initWithRootViewController:newsVC] autorelease];
    
    //top
    TopViewController *topVC = [[[TopViewController alloc] init] autorelease];
    BaseNavigationController *topNav = [[[BaseNavigationController alloc] initWithRootViewController:topVC] autorelease];
    
    //影院
    CinemaViewController *cinemaVC = [[[CinemaViewController alloc] init] autorelease];
    BaseNavigationController *cinemaNav = [[[BaseNavigationController alloc] initWithRootViewController:cinemaVC] autorelease];
    
    //更多
    /*
    MoreViewController *moreVC = [[[MoreViewController alloc] init] autorelease];
    BaseNavigationController *moreNav = [[[BaseNavigationController alloc] initWithRootViewController:moreVC] autorelease];*/
    
    //添加所有控制器到TabBarItem上面
    NSArray *viewControllers = @[usaNav,newsNav,topNav,cinemaNav/*,moreNav*/];
    [self setViewControllers:viewControllers animated:YES];
}

- (void)customTabBarView
{
    //自定义TabBar背景视图
    _tabBarBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-49, kDeviceWidth, 49)];
    _tabBarBG.userInteractionEnabled = YES;//用户交互
    _tabBarBG.image = [UIImage imageNamed:@"tab_bg_all"];
    [self.view addSubview:_tabBarBG];
    
    //自定义TabBar选中视图
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 1+_tabBarBG.height/2.0-45.0/2.0, 50, 45)];
    _selectView.image  = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    [_tabBarBG addSubview:_selectView];
    
    //整理数据
    NSArray *imgs = @[@"movie_home",@"msg_new",@"start_top250",@"icon_cinema",@"more_setting"];
    NSArray *txts = @[@"电影",@"新闻",@"Top",@"影院",@"更多"];
    
    //添加Items视图
    int x = 0;
    for (int i=0; i<5; i++) {
        
        ItemView *itemView = [[ItemView alloc] initWithFrame:CGRectMake(5+x, _tabBarBG.height/2.0-45.0/2.0+2.0, 50, 45)];
        itemView.tag = i;
        itemView.delegate = self;//设置代理
        itemView.item.image = [UIImage imageNamed:imgs[i]];
        itemView.title.text = txts[i];
        [_tabBarBG addSubview:itemView];
        [itemView release];
        
        x += 65;
    }
}

// 移除更多页面的视图
- (void)removeMoreView
{
    if ([_moreView superview]) {
        
        // 先隐藏，后删除 － 添加消失动画，增强用户体验
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        _moreView.alpha = 0;
        [UIView commitAnimations];
        
        // 移除视图
        [_moreView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];//1
        [_moreView release], _moreView = nil;//0
    }

}

/////////////////////////////////////////////

// 点击TabBar的item项，切换显示
int _lastIndex = 0;
- (void)changeViewController:(NSInteger)index
{
    // 获取位置信息，若用户点到第五个Item，并且_moreView存在，location值应该为上一次的值
    int location = (index==4 && [_moreView superview]) ? _lastIndex : index;
    
    if (index>=4 && _moreView== nil) {
        
        _moreView = [[MoreView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-49)];//1
        _moreView.delegate = self;
        _moreView.tag = index;
        
        [self.view addSubview:_moreView];//2
        
    } else {

        // 移除更多页面的视图
        [self removeMoreView];
        
        //在Items中，切换选中视图的控制器
        //self.selectedIndex = index; // 存在bag
        self.selectedIndex = location;
    }
    
    // 移动选中视图的位置
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _selectView.frame = CGRectMake(7+64*location, 1+_tabBarBG.height/2.0-45.0/2.0, 50, 45);
    [UIView commitAnimations];
    
    // 记录上一次选中的位置信息
    _lastIndex = (index==4) ? _lastIndex : index;
}

#pragma mark - Public Methods

- (void)showOrHiddenCustomedTabBarView:(BOOL)isShow
{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.26];//0.28
//    if (isShow) {
//        _tabBarBG.left = 0;
//        //_tabBarBG.alpha = 1;
//    } else {
//        _tabBarBG.left = -93.5;//250
//        //_tabBarBG.alpha = 0;
//    }
//    [UIView commitAnimations];
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.6];//0.1
//    if (isShow) {
//        _tabBarBG.alpha = 1;
//    } else {
//        _tabBarBG.alpha = 0;
//    }
//    [UIView commitAnimations];
    
    // 动画设置
    [UIView beginAnimations:nil context:NULL];
    if (isShow) {
        [UIView setAnimationDuration:0.28];//0.28
        _tabBarBG.left = 0;
    } else {
        
        [UIView setAnimationDuration:0.18];//0.18
        _tabBarBG.left = -320;
    }
    [UIView commitAnimations];
}


#pragma mark - ItemView Delegate

// －－－－利用代理传值－－－－－－－
- (void)itemView:(ItemView *)itemView didSelectItemAtIndex:(NSInteger)index
{
    [self changeViewController:index];
}

#pragma mark - MoreView Delegate

- (void)moreView:(MoreView *)moreView didTouchBackgroundWithTag:(NSInteger)tag
{
    [self changeViewController:tag];
}

- (void)moreView:(MoreView *)moreView didSelectRowAtIndex:(NSInteger)index
{
    // NSLog(@"didSelectRowAtIndex:%d",index);
    
    // 移除更多页面的视图
    [self removeMoreView];
    
    // 先获得当前的viewControllers数组
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.viewControllers];
    
    // 判断当前视图控制器的个数，若大于等于5个就删除最后一个,注意内存是否得到正确的释放
    if (self.viewControllers.count >= 5) {
        [vcs removeLastObject];
    }
    
    // 创建一个新的控制器
    MoreViewController *moreVC = [[[MoreViewController alloc] init] autorelease];
    if (index == 0) {
        //moreVC = [[[MoreViewController alloc] init] autorelease];
        moreVC.title = @"搜索";
    }
    else if (index == 1) {
        //moreVC = [[[MoreViewController alloc] init] autorelease];
        moreVC.title = @"收藏";
    }
    else if (index == 2) {
        //moreVC = [[[MoreViewController alloc] init] autorelease];
        moreVC.title = @"设置";
    }
    else {
        //moreVC = [[[MoreViewController alloc] init] autorelease];
        moreVC.title = @"关于";
    }
    
    // 把more视图的控制器作为导航控制器的根视图控制器
    BaseNavigationController *moreNav = [[[BaseNavigationController alloc] initWithRootViewController:moreVC] autorelease];
    
    // 把创建的视图控制器，加入控制器数组中
    [vcs addObject:moreNav];
    
    // 重新设置控制器队列
    [self setViewControllers:vcs animated:YES];
    
    self.selectedIndex = 4; // 切换到当前的选择
    _lastIndex = 4;         // 记住上次的选择
    
    // NSLog(@"当前viewControllers的数量：%d",self.viewControllers.count);
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if (self.view.window == nil) {
        self.view = nil;
        //将所有的强引用释放
        [_tabBarBG release],_tabBarBG = nil;
        [_selectView release],_selectView = nil;
        [_moreView release],_moreView = nil;
    }
}

- (void)dealloc
{
    [_tabBarBG release],_tabBarBG = nil;
    [_selectView release],_selectView = nil;
    [_moreView release],_moreView = nil;
    
    [super dealloc];
}

@end
