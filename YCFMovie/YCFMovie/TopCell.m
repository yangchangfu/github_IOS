//
//  TopCell.m
//  YCFMovie
//
//  Created by yangchangfu on 15-4-29.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "TopCell.h"
#import "TopView.h"

@interface TopCell ()

- (void)initSubviews;

@end

@implementation TopCell

#pragma mark - init Methods
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initSubviews
{
    int x=0;
    for (int index=0; index<3; index++) {
        TopView *topView = [[TopView alloc] initWithFrame:CGRectMake(15+x, 20, 90, 130)];
        topView.backgroundColor = [UIColor clearColor];
        topView.tag = 501+index;
        //imgView.hidden = YES;
        [self.contentView addSubview:topView];
        [topView release];
        
        x += 100;
    }
}

#pragma mark - Setter Methods
- (void)setImgsArray:(NSArray *)imgsArray
{
    if (_imgsArray != imgsArray) {
        [_imgsArray release];
        _imgsArray = [imgsArray retain];
        
        for (int index=0; index<3; index++) {
            TopView *topView = (TopView *) [self.contentView viewWithTag:501+index];
            topView.hidden = YES;
        }
    }
}


#pragma mark - Overwrite Super Methods
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int index=0; index<self.imgsArray.count; index++) {
        TopView *topView = (TopView *) [self.contentView viewWithTag:501+index];
        topView.topModel = _imgsArray[index];
        topView.hidden = NO;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Memory
- (void)dealloc
{
    [_imgsArray release],_imgsArray = nil;
    //self.imgsArray = nil;
    
    [super dealloc];
}

@end
