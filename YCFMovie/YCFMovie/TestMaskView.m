//
//  TestMaskView.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-28.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "TestMaskView.h"

@implementation TestMaskView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"dead test");
    
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
