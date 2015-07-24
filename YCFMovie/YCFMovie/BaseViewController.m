//
//  BaseViewController.m
//  YCFMovie
//
//  基视图控制器
//
//  Created by yangchangfu on 15-5-2.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // 当push时，隐藏tabbar视图，否则依然显示
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    [view release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.isShowBackItem) {
    
        [self.navigationItem setHidesBackButton:YES];// 隐藏系统返回按钮
        // 定制返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 44, 44);
        [backBtn setImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backBtn] autorelease];
    }
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
    [super dealloc];
}

@end
