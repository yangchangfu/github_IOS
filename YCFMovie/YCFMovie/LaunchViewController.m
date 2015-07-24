//
//  LaunchViewController.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-30.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "LaunchViewController.h"
#import "MainViewController.h"


#define kLogoViewWidth  80
#define kLogoViewHeight 81

@interface LaunchViewController ()

- (void)setProperty;
- (void)loadLogoView;
- (void)showLogoView;

@end

@implementation LaunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    [view release];
    
    [self setProperty];
    [self loadLogoView];
}

- (void)setProperty
{
    UIImageView *imgView = (UIImageView *)self.view;
    if (kDeviceHeight == 568) {
        _imagesCount = 18;
        _maxRow = 7;
        
        // 设置背景图片，并做好适配
        imgView.image = [UIImage imageNamed:@"Default-568h"];
    } else {
        _imagesCount = 16;
        _maxRow = 6;
        
        // 设置背景图片，并做好适配
        imgView.image = [UIImage imageNamed:@"Default"];
    }
}

// 加载所有启动界面图片，并设置alpha为完全透明
- (void)loadLogoView
{
    // 初始化数组
    _logoArray = [[NSMutableArray alloc] initWithCapacity:_imagesCount];
    
    int x=0,y=0;
    for (int index=0; index<_imagesCount; index++) {
        
        // 创建视图
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.alpha = 0;
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",index+1]];
        [self.view addSubview:imgView];
        [imgView release];
        
        // 设置frame
        imgView.width  = kLogoViewWidth;
        imgView.height = kLogoViewHeight;
        imgView.left  += x;
        imgView.top   += y;
        
        // 更改坐标
        if (index < 3) {
            x += imgView.width;
        } else if (index < _maxRow+2) {
            y += imgView.height;
        } else if (index < _maxRow+5) {
            x -= imgView.width;
        } else {
            y -= imgView.height;
        }
        
        // 获得对象，存储对象
        [_logoArray addObject:imgView];
    }
}

static int i = 0;

- (void)showLogoView
{
    // 跳出递归函数
    if (i >= [_logoArray count]) {
        
        /*
        if ([self.delegate respondsToSelector:@selector(loadLogoViewAnimationEnd)]) {
            
            [self.delegate loadLogoViewAnimationEnd];
        }
         */
        
        // 显示状态栏
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        
        // 加载主视图控制器
        MainViewController *mainVC = [[[MainViewController alloc] init] autorelease];
        self.view.window.rootViewController = mainVC;

        return;
    }
    
    UIImageView *imgView = _logoArray[i];
    
    // 添加一个动画效果
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    imgView.alpha = 1;
    [UIView commitAnimations];
    
    // 延时执行以下
    [self performSelector:@selector(showLogoView) withObject:nil afterDelay:0.2];
    i++;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 递归显示logo动画
    [self showLogoView];
    
    // 请求网络，更新版本
    // 弹出提示－版本更新
}

- (void)dealloc
{
    NSLog(@"launchView dead!");//测试内存管理
    
    [_logoArray release], _logoArray = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (self.view.window == nil) {
        self.view = nil;
        
        [_logoArray release], _logoArray = nil;
    }
}

@end
