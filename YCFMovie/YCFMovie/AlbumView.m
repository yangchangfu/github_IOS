//
//  AlbumView.m
//  YCFMovie
//
//  Created by yangchangfu on 15-5-2.
//  Copyright (c) 2015年 深圳市发展科技. All rights reserved.
//

#import "AlbumView.h"

@implementation AlbumView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // self.bounds 一定是这个，或是（0，0，self.with,self,height）;
        _scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollview.minimumZoomScale = 1;
        _scrollview.maximumZoomScale = 3;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.backgroundColor = [UIColor clearColor];
        _scrollview.scrollsToTop = NO;
        _scrollview.delegate = self;
        
        [self addSubview:_scrollview];
        
        _imageView = [[UIImageView alloc] initWithFrame:_scrollview.frame];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        // 一定要加在滑动视图上，否则无法定位放大图片zoomToSet
        [_scrollview addSubview:_imageView];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOutOrIn:)];
        doubleTap.numberOfTapsRequired = 2;
        [_imageView addGestureRecognizer:doubleTap];
        [doubleTap release];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenOrShow:)];
        [_imageView addGestureRecognizer:singleTap];
        [singleTap release];
        
        // 双击时，取消单击事件
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}

#pragma mark - Setter Methods
- (void)setImgURL:(NSString *)imgURL
{
    if (_imgURL != imgURL) {
        [_imgURL release];
        _imgURL = [imgURL retain];
    }
}

#pragma mark - Public Methods
int i=0;
- (void)loadScrollViewImages
{
    if (_imageView.image == nil) {
        
        //i++;
        //NSLog(@"加载次数->> %d",i);
        
        // 异步网络请求图片
        [_imageView setImageWithURL:[NSURL URLWithString:_imgURL]];
        
    }
}

#pragma mark - ScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

#pragma mark - Target Action
- (void)zoomOutOrIn:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:_imageView];
    
    if (_scrollview.zoomScale != 1) {
        [_scrollview setZoomScale:1 animated:YES];
        
    } else {
        //[_scrollview setZoomScale:2.5 animated:YES];
        [_scrollview zoomToRect:CGRectMake(point.x-50, point.y-50, 100, 100) animated:YES];
    }
}

- (void)hiddenOrShow:(UITapGestureRecognizer *)tap
{
    //NSLog(@"hiddenOrShow");
    
    if ([self.delegate respondsToSelector:@selector(albumView:HiddenOrShowSidedViews:)]) {
        
        [self.delegate albumView:self HiddenOrShowSidedViews:nil];
    }
}


#pragma mark - Memory
- (void)dealloc
{
    [_scrollview release],_scrollview = nil;
    [_imageView release],_imageView = nil;
    self.imgURL = nil;
    
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
