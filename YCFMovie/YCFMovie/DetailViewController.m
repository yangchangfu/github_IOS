//
//  DetailViewController.m
//  YCFMovie
//
//  Created by yangchangfu on 15-5-3.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "DetailViewController.h"
#import "MainViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    self.view.backgroundColor = [UIColor orangeColor];
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
	// Do any additional setup after loading the view.
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
