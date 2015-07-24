//
//  MoreView.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "MoreView.h"
#import <QuartzCore/QuartzCore.h>


@implementation MoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.2 green:0.5 blue:0.2 alpha:0.5];
        
        // 适配
        CGRect frame = (kDeviceHeight==480)? CGRectMake(170, 255, 145, 183): CGRectMake(168, 340, 145, 183);
        
        _popView = [[UIImageView alloc] initWithFrame:frame];
        _popView.image = [UIImage imageNamed:@"moreView_setting_new"];
        //_popView.contentMode = UIViewContentModeScaleAspectFill;
        _popView.userInteractionEnabled = YES;
        [self addSubview:_popView];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _popView.width, _popView.height-8) style:UITableViewStylePlain];
        _tableView.layer.cornerRadius = 5;// 圆角设置
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.scrollEnabled = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_popView addSubview:_tableView];
    }
    return self;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(moreView:didSelectRowAtIndex:)]) {
        
        // 传送用户点击的行号
        [self.delegate moreView:self didSelectRowAtIndex:indexPath.row];
    }
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"more_search"];
        cell.textLabel.text = @"搜索";
    }
    else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"more_fav"];
        cell.textLabel.text = @"收藏";
    }
    else if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"more_set"];
        cell.textLabel.text = @"设置";
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"more_info"];
        cell.textLabel.text = @"关于";
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - Touch Actions
// 点击视图后，调用此方法，扑捉事件
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__FUNCTION__);
    
    if ([self.delegate respondsToSelector:@selector(moreView:didTouchBackgroundWithTag:)]) {
        
        // 传送tag值
        [self.delegate moreView:self didTouchBackgroundWithTag:self.tag];
    }
}

#pragma mark - Memory
- (void)dealloc
{
    NSLog(@"_moreView dead!");//测试内存释放
    
    [_popView release], _popView = nil;
    [_tableView release],_tableView = nil;
    
    [super dealloc];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
