//
//  BaseNavigationController.m
//  YCFMovie
//
//  基导航控制器
//
//  Created by yangchangfu on 15-4-24.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    /*
    UIDevice *current = [UIDevice currentDevice];
    current.systemVersion
     */
    
    // 5.0 以上版本
    // 自定义navigationBar
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        //[self.navigationBar setBackgroundImage:[UIImage imageName:@"nav_bg_all"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_all"] forBarMetrics:UIBarMetricsDefault];
    }
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
}

@end

// 5.0 以下版本
// 自定义navigationBar
@implementation UINavigationBar (customBackground)

- (void)drawRect:(CGRect)rect
{
    UIImage *img = [UIImage imageNamed:@"nav_bg_all"];
    [img drawInRect:rect];
}

@end
